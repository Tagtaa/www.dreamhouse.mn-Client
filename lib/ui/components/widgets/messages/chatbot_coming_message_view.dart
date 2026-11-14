import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_images.dart';
import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/constants/text_constants.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../../core/models/auth/api/messages/send/chat_message_model_data.dart';
import '../../../../core/utils/extensions/size_extensions.dart';
import '../custom_image_network.dart';

const double _messageBoxRadius = 15.0;

class ChatbotComingMessageView extends StatelessWidget {
  const ChatbotComingMessageView({
    super.key,
    this.chatMessageModel,
  });

  final ChatMessageModel? chatMessageModel;

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = chatMessageModel?.imageUrl;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AppImages.support_chat(height: AppSize.emptySizeLow),
              const SizedBox(width: AppSize.emptySizeLowest),
              Text(
                TextConstants.operator,
                style: AppTextStyles.labelSmall(color: AppColors.text),
              ),
              const SizedBox(width: AppSize.emptySizeLowest),

              Text(
                chatMessageModel?.formattedDate ?? '',
                style: AppTextStyles.labelSmall(
                  color: AppColors.chatBotTextColor,
                  fontSize: AppSize.smallestFontSize,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.emptySizeLowest),
          Container(
            height: imageUrl != null ? context.dw(AppSize.containerHeightRateLowMedium) : null,
            width: context.dw((imageUrl == null ? AppSize.containerHeightRate : AppSize.containerHeightRateLowMedium)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: imageUrl != null ? const Radius.circular(_messageBoxRadius) : Radius.zero,
                topRight: const Radius.circular(_messageBoxRadius),
                bottomLeft: const Radius.circular(_messageBoxRadius),
                bottomRight: const Radius.circular(_messageBoxRadius),
              ),
              color: AppColors.secondary,
            ),
            child: Padding(
              padding: EdgeInsets.all(imageUrl == null ? AppSize.padding : AppSize.paddingLowest),
              child: switch (imageUrl == null) {
                true => Text(
                  chatMessageModel?.content ?? '',
                  style: AppTextStyles.labelSmall(
                    color: AppColors.chatBotMessageSendingTextColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                false => ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(_messageBoxRadius)),
                  child: CustomImageNetwork(imageUrl!),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
