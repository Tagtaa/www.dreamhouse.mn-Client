import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/configs/constants/app_images.dart';
import '../../../core/exceptions/api_exception.dart';
import '../../../core/init/app_locator.dart';
import '../../../core/models/auth/api/anonymous_messages/list/chat_messages_list_response_model.dart';
import '../../../core/models/auth/api/anonymous_messages/send/anonymous_chat_message_model_data.dart';
import '../../../core/models/auth/api/anonymous_messages/send/anonymous_chat_message_response_model.dart';
import '../../../core/models/auth/api/anonymous_messages/send/anonymous_chat_socket_message_response_model.dart';
import '../../../core/models/result.dart';
import '../../../core/models/rx.dart';
import '../../../core/routing/app_navigation.dart';
import '../../../core/services/app/app_service.dart';
import '../../../core/services/auth/message/anonymous_message_service.dart';
import '../../../core/services/local_storage/local_storage_service.dart';
import '../../../core/utils/app_logger.dart';
import '../../components/overlay/alert_notification_overlay.dart';
import '../base_screen_controller.dart';
import '../image_picker/image_picker_screen_args.dart';

final class ChatbotAnonymousScreenController {
  final Service<AnonymousMessageService> _messageService;

  ChatbotAnonymousScreenController(
    this._messageService,
  );

  final ScrollController scrollController = ScrollController();
  final Rx<List<AnonymousChatMessageModel>> allMessages = Rx<List<AnonymousChatMessageModel>>(
    <AnonymousChatMessageModel>[],
  );

  final Rx<double> scrollOffset = Rx<double>(0.0);
  final Rx<bool> isLoadingMore = Rx<bool>(false);
  final Rx<bool> isBusy = Rx<bool>(false);

  final TextEditingController messageController = TextEditingController();

  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  BuildContext? context;
  IO.Socket? socket;

  Rx<bool> isConnected = Rx<bool>(false);

  Rxn<String> sessionId = Rxn<String>();

  static const int _itemsPerPage = 10;

  Future<void> onInit(BuildContext buildContext) async {
    context = buildContext;
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });

    await readSessionId();
    await refresh();
    await connectSocket();
  }

  Future<void> readSessionId() async {
    sessionId.value = await ServiceLocator.get<LocalStorageService>().read(Keys.sessionId);
  }

  Future<void> refresh() async {
    _currentPage = 1;
    _hasMore = true;
    await _fetchMaterials(page: _currentPage);
  }

  void _loadMore() async {
    if (_isFetching || !_hasMore) {
      return;
    }
    await _fetchMaterials(page: _currentPage + 1);
  }

  Future<void> _fetchMaterials({required int page}) async {
    if (_isFetching || sessionId.value == null || (sessionId.value != null && sessionId.value!.isEmpty)) {
      return;
    }

    _isFetching = true;

    if (page > 1) {
      isLoadingMore(set: () => true);
    } else {
      isBusy(set: () => true);
    }

    await _messageService().getAllChatMessages(page: page, limit: _itemsPerPage, sessionId: sessionId.value!).then(
      (Result<AnonymousChatMessagesListResponseModel, ApiException> result) {
        result.on(
          success: (AnonymousChatMessagesListResponseModel response) async {
            final List<AnonymousChatMessageModel>? newMessages = response.messages;
            final Pagination pagination = response.pagination;

            if (page == 1) {
              allMessages(set: () => newMessages ?? <AnonymousChatMessageModel>[]);
              await _scrollToBottom();
            } else {
              allMessages(
                set: () => <AnonymousChatMessageModel>[
                  ...allMessages.value,
                  ...newMessages ?? <AnonymousChatMessageModel>[],
                ],
              );
            }

            _currentPage = pagination.page;
            _totalPages = pagination.pages;
            _hasMore = _currentPage < _totalPages;
          },
          failure: (ApiException e) async {
            await showAlertNotification(context, message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );

    if (page > 1) {
      isLoadingMore(set: () => false);
    } else {
      isBusy(set: () => false);
    }
    _isFetching = false;
  }

  Future<void> _scrollToBottom() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendTextMessages() async {
    await _messageService().sendTextMessage(content: messageController.text.trim(), sessionId: sessionId.value).then(
      (Result<AnonymousChatMessageResponseModel, ApiException> result) {
        result.on(
          success: (AnonymousChatMessageResponseModel response) async {
            if (sessionId.value == null) {
              final String tempSessionId = response.data?.sessionId ?? '';
              await ServiceLocator.get<LocalStorageService>().write(Keys.sessionId, tempSessionId);
              sessionId.value = tempSessionId;
              if (allMessages.value.isEmpty) {
                connectSocket();
                refresh();
              }
            }
            messageController.text = '';
          },
          failure: (ApiException e) async {
            await showAlertNotification(context, message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
  }

  void _sendImageMessages(Uint8List bytes) async {
    await _messageService().sendImageMessage(bytes, sessionId: sessionId.value).then(
      (Result<AnonymousChatMessageResponseModel, ApiException> result) {
        result.on(
          success: (AnonymousChatMessageResponseModel response) async {
            if (sessionId.value == null) {
              final String tempSessionId = response.data?.sessionId ?? '';
              await ServiceLocator.get<LocalStorageService>().write(Keys.sessionId, tempSessionId);
              sessionId.value = tempSessionId;
              if (allMessages.value.isEmpty) {
                connectSocket();
                refresh();
              }
            }
          },
          failure: (ApiException e) async {
            await showAlertNotification(context, message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
  }

  void onTapImage() {
    AppNavigation.goToImagePicker(
      context,
      args: ImagePickerScreenArgs(
        onPicked: (Uint8List bytes) {
          _sendImageMessages(bytes);
        },
        onPickedPath: (String? path) {
          AppLogger.debug(path);
        },
      ),
    );
  }

  Future<void> connectSocket() async {
    final String baseUrl = ServiceLocator.get<AppService>().initialConfig.baseUrlChat;

    if (sessionId.value != null) {
      socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(<String>['websocket'])
            .setAuth(<dynamic, dynamic>{
              'isAnonymous': true,
              'sessionId': sessionId.value,
            })
            //.enableAutoConnect()
            .disableAutoConnect()
            .enableForceNew()
            .build(),
      );
      socket!.connect();

      socket!.onConnect((_) {
        AppLogger.debug('✅ Anonymous Socket CONNECTED! Socket ID: ${socket!.id}');
        AppLogger.debug('🔌 Session ID: $sessionId');
        isConnected(set: () => true);
      });

      socket!.onDisconnect((_) {
        AppLogger.debug('❌ Anonymous Socket disconnected');
        isConnected(set: () => false);
      });

      socket!.onAny((String event, data) {
        AppLogger.debug('📡 Socket Event Received: $event');
        AppLogger.debug('📡 Event Data: $data');
      });

      socket!.onError((error) {
        AppLogger.debug('🔌 Socket error: $error');
      });

      socket!.on('new_message', (data) async {
        AppLogger.debug('📊 Full Data: $data');

        final AnonymousChatSocketMessageResponseModel response = AnonymousChatSocketMessageResponseModel.fromJson(data);
        AppLogger.debug('📊 Parsed Response: ${response.toString()}');

        allMessages(
          set: () => <AnonymousChatMessageModel>[
            ?response.message,
            ...allMessages.value,
          ],
        );

        await _scrollToBottom();
      });
    } else {
      AppLogger.debug('❌ SessionId not found! Send message first.');
    }
  }

  void onDispose() {
    scrollController.dispose();
    if (socket != null) {
      AppLogger.debug('👋 The anonymous socket connection is being completely terminated...');
      socket!.disconnect();
      socket!.close();
      socket = null;
    }
  }
}
