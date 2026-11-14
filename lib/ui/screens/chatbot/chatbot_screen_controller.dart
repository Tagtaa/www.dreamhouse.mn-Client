import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/configs/constants/app_images.dart';
import '../../../core/exceptions/api_exception.dart';
import '../../../core/init/app_locator.dart';
import '../../../core/models/auth/api/messages/list/chat_messages_list_response_model.dart';
import '../../../core/models/auth/api/messages/send/chat_message_model_data.dart';
import '../../../core/models/auth/api/messages/send/chat_message_response_model.dart';
import '../../../core/models/auth/api/messages/send/chat_socket_message_response_model.dart';
import '../../../core/models/result.dart';
import '../../../core/models/rx.dart';
import '../../../core/routing/app_navigation.dart';
import '../../../core/services/app/app_service.dart';
import '../../../core/services/auth/message/message_service.dart';
import '../../../core/services/auth/token/token_decoder.dart';
import '../../../core/services/local_storage/local_storage_service.dart';
import '../../../core/utils/app_logger.dart';
import '../../components/overlay/alert_notification_overlay.dart';
import '../base_screen_controller.dart';
import '../image_picker/image_picker_screen_args.dart';

final class ChatbotScreenController {
  final Service<MessageService> _messageService;

  ChatbotScreenController(
    this._messageService,
  );

  final ScrollController scrollController = ScrollController();
  final Rx<List<ChatMessageModel>> allMessages = Rx<List<ChatMessageModel>>(<ChatMessageModel>[]);

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

  static const int _itemsPerPage = 10;

  Future<void> onInit(BuildContext buildContext) async {
    context = buildContext;
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });

    await connectSocket();
    await refresh();
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
    if (_isFetching) {
      return;
    }

    _isFetching = true;

    if (page > 1) {
      isLoadingMore(set: () => true);
    } else {
      isBusy(set: () => true);
    }

    await _messageService()
        .getAllChatMessages(
          page: page,
          limit: _itemsPerPage,
        )
        .then(
          (Result<ChatMessagesListResponseModel, ApiException> result) {
            result.on(
              success: (ChatMessagesListResponseModel response) async {
                final List<ChatMessageModel>? newMessages = response.messagesData;
                final Pagination pagination = response.pagination;

                if (page == 1) {
                  allMessages(set: () => newMessages ?? <ChatMessageModel>[]);
                  await _scrollToBottom();
                } else {
                  allMessages(
                    set: () => <ChatMessageModel>[
                      ...allMessages.value,
                      ...newMessages ?? <ChatMessageModel>[],
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
    await _messageService()
        .sendTextMessage(
          content: messageController.text.trim(),
        )
        .then(
          (Result<ChatMessageResponseModel, ApiException> result) {
            result.on(
              success: (_) async {
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
    await _messageService().sendImageMessage(bytes).then(
      (Result<ChatMessageResponseModel, ApiException> result) {
        result.on(
          success: (_) async {},
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

    final String? accessToken = await ServiceLocator.get<LocalStorageService>().read(Keys.accessToken);
    if (accessToken != null && !JwtDecoder.isExpired(accessToken)) {
      socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(<String>['websocket'])
            .setAuth(<dynamic, dynamic>{
              'token': accessToken,
            })
            //.enableAutoConnect()
            .disableAutoConnect()
            .enableForceNew()
            .build(),
      );
      socket!.connect();

      socket!.onConnect((_) {
        AppLogger.debug('✅ Socket CONNECTED! Socket ID: ${socket!.id}');
        AppLogger.debug('🔌 Auth token length: ${accessToken.length}');
        isConnected(set: () => true);
      });
      socket!.onDisconnect((_) {
        AppLogger.debug('❌ Socket disconnected');
        isConnected(set: () => false);
      });

      socket!.onAny((String event, data) {
        AppLogger.debug('📡 Socket Event Received: $event');
        AppLogger.debug('📡 Event Data: $data');
      });

      socket!.onError((error) {
        AppLogger.debug('🔌 Socket error: $error');
      });

      socket!.on('new_user_message', (data) async {
        AppLogger.debug('📊 Full Data: $data');

        final ChatSocketMessageResponseModel newMessage = ChatSocketMessageResponseModel.fromJson(data);
        AppLogger.debug(newMessage.toString());

        allMessages(
          set: () => <ChatMessageModel>[
            ?newMessage.message,
            ...allMessages.value,
          ],
        );

        await _scrollToBottom();
      });
    }
  }

  void onDispose() {
    scrollController.dispose();
    if (socket != null) {
      AppLogger.debug('👋 The user socket connection is being completely terminated...');
      socket!.disconnect();
      socket!.close();
      socket = null;
    }
  }
}
