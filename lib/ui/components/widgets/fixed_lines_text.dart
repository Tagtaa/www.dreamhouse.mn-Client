import 'package:flutter/material.dart';

/// Text that always takes [lines] lines of height: shorter text keeps the space,
/// longer text ends with "…". Keeps card layouts even when titles differ in length.
class FixedLinesText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int lines;

  const FixedLinesText(this.text, {super.key, this.style, this.lines = 3});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Invisible placeholder that reserves the height of [lines] lines
        Opacity(opacity: 0, child: Text('\n' * (lines - 1), style: style, maxLines: lines)),
        Text(text, style: style, maxLines: lines, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
