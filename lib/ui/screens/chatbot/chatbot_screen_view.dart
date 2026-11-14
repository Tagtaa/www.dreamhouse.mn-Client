import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_icons.dart';
import '../../../../core/configs/constants/app_images.dart';
import '../../../../core/configs/constants/app_size.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../core/init/app_locator.dart';
import '../../../core/models/auth/api/messages/send/chat_message_model_data.dart';
import '../../../core/models/rx.dart';
import '../../../core/services/auth/message/message_service.dart';
import '../../../core/utils/extensions/size_extensions.dart';
import '../../components/widgets/messages/chatbot_coming_message_view.dart';
import '../../components/widgets/messages/chatbot_sending_message_view.dart';
import '../../components/widgets/custom_back_button.dart';
import '../../components/widgets/gesture_detector.dart';
import '../../components/widgets/obx.dart';
import 'chatbot_screen_args.dart';
import 'chatbot_screen_controller.dart';

const double _thicknessDivider = 0.7;

@RoutePage()
final class ChatbotScreenView extends StatefulWidget {
  const ChatbotScreenView({
    super.key,
    this.args = const ChatbotScreenArgs(),
  });

  final ChatbotScreenArgs args;

  @override
  State<ChatbotScreenView> createState() => _ChatbotScreenViewState();
}

class _ChatbotScreenViewState extends State<ChatbotScreenView> {
  final FocusNode _focusNode = FocusNode();
  final ChatbotScreenController controller = ChatbotScreenController(() => ServiceLocator.get<MessageService>());

  @override
  void initState() {
    super.initState();
    controller.onInit(context);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {});
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    controller.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildMessageList() {
      return Expanded(
        child: Obx(
          controller.allMessages,
          builder: (BuildContext context, Rx<List<ChatMessageModel>> allMessages, Widget? child) {
            return ListView.builder(
              reverse: true,
              controller: controller.scrollController,
              padding: const EdgeInsets.all(AppSize.padding),
              itemCount: allMessages.value.length,
              itemBuilder: (BuildContext context, int index) {
                final ChatMessageModel message = allMessages.value[index];
                return switch (message.senderType == 'admin') {
                  true => ChatbotComingMessageView(chatMessageModel: message),
                  false => ChatbotSendingMessageView(chatMessageModel: message),
                };
              },
            );
          },
        ),
      );
    }

    Widget buildDivider() {
      return const Divider(
        thickness: _thicknessDivider,
        color: AppColors.inversePrimary,
      );
    }

    Widget buildInputArea() {
      return Padding(
        padding: const EdgeInsets.all(AppSize.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: AppSize.padding),
                  child: CustomGestureDetector(onTap: controller.onTapImage, child: AppIcons.image_placeholder()),
                ),
                Container(
                  width: context.dw(0.7),
                  constraints: const BoxConstraints(
                    maxHeight: 120,
                  ),
                  child: TextField(
                    controller: controller.messageController,
                    focusNode: _focusNode,
                    maxLines: 5,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: TextConstants.askYourQuestion,
                      hintStyle: AppTextStyles.labelSmall(color: AppColors.chatBotTextColor),
                      helperMaxLines: 5,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    scrollPhysics: const BouncingScrollPhysics(),
                  ),
                ),
              ],
            ),
            CustomGestureDetector(onTap: controller.sendTextMessages, child: AppIcons.send()),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        leading: null,
        automaticallyImplyLeading: false,
        title: Stack(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.padding),
                    child: AppImages.support_chat(),
                  ),
                  Text(
                    TextConstants.supportChat,
                    style: AppTextStyles.labelMedium(color: AppColors.buttonText),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              child: SizedBox(
                width: AppSize.iconSizeNormal,
                height: AppSize.iconSizeNormal,
                child: CustomBackButton(),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Obx(
                controller.isBusy,
                builder: (BuildContext context, Rx<bool> isBusy, Widget? child) {
                  return switch (isBusy.value) {
                    true => const Center(child: CircularProgressIndicator()),
                    false => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildMessageList(),
                        buildDivider(),
                        buildInputArea(),
                      ],
                    ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
