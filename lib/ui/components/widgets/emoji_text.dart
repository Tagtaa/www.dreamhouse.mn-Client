import 'package:flutter/material.dart';

/// Chat message text with emoji drawn at twice the text size.
/// Drop-in for `Text(text, style: ...)` in the support chat bubbles.
class EmojiText extends StatelessWidget {
  const EmojiText(this.text, {super.key, required this.style});

  final String text;
  final TextStyle style;

  /// One emoji: pictograph (+ variation selector / skin tone), joined
  /// sequences (👨‍👩‍👧) and flags (two regional indicators).
  static final RegExp _emoji = RegExp(
    r'(\p{Regional_Indicator}{2}|\p{Extended_Pictographic}(?:️|\p{Emoji_Modifier})?(?:‍\p{Extended_Pictographic}(?:️|\p{Emoji_Modifier})?)*)',
    unicode: true,
  );

  @override
  Widget build(BuildContext context) {
    final TextStyle emojiStyle = style.copyWith(
      fontSize: (style.fontSize ?? 14) * 2,
      height: 1.1,
    );

    final List<InlineSpan> spans = <InlineSpan>[];
    int last = 0;
    for (final RegExpMatch match in _emoji.allMatches(text)) {
      if (match.start > last) {
        spans.add(TextSpan(text: text.substring(last, match.start)));
      }
      spans.add(TextSpan(text: match.group(0), style: emojiStyle));
      last = match.end;
    }
    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last)));
    }

    return Text.rich(TextSpan(children: spans), style: style);
  }
}
