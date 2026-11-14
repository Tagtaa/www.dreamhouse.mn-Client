import 'package:flutter/material.dart';

import 'custom_image_network.dart';

/// Image in a support-chat bubble. Tap opens it full screen (pinch to zoom).
class ChatImage extends StatelessWidget {
  const ChatImage(this.imageUrl, {super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Зургийг томоор харах',
      child: GestureDetector(
        onTap: () => showChatImagePreview(context, imageUrl),
        child: CustomImageNetwork(imageUrl),
      ),
    );
  }
}

Future<void> showChatImagePreview(BuildContext context, String imageUrl) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.9),
    builder: (BuildContext dialogContext) {
      return Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            // Tap outside the image closes; pinch / double-drag zooms
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(dialogContext).pop(),
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 5,
                  child: Center(
                    child: CustomImageNetwork(imageUrl, boxFit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(dialogContext).padding.top + 8,
              right: 8,
              child: IconButton(
                tooltip: 'Хаах',
                onPressed: () => Navigator.of(dialogContext).pop(),
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                style: IconButton.styleFrom(backgroundColor: Colors.black45),
              ),
            ),
          ],
        ),
      );
    },
  );
}
