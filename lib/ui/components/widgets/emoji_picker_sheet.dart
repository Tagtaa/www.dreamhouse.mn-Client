import 'package:flutter/material.dart';

/// Emoji palette for the support chat (same set as the website chat).
const List<(String, String, List<String>)> _emojiCategories = <(String, String, List<String>)>[
  (
    '😀',
    'Царай',
    <String>[
      '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣', '😊', '😇', '🙂', '😉', '😌', '😍', '🥰', '😘', //
      '😋', '😛', '😜', '🤪', '🤗', '🤭', '🤔', '🤨', '😐', '😑', '😶', '🙄', '😏', '😬', '😮', '😯', //
      '😲', '😳', '🥺', '😢', '😭', '😤', '😠', '😡', '🤯', '😱', '😨', '😰', '😴', '🤤', '😷', '🤒', //
      '🤕', '😎', '🤓', '🥳',
    ],
  ),
  (
    '👍',
    'Дохио',
    <String>[
      '👍', '👎', '👌', '✌️', '🤞', '🤟', '🤘', '🤙', '👋', '🤝', '🙏', '👏', '🙌', '💪', '👆', '👇', //
      '👈', '👉', '☝️', '✋', '🤚', '🖐️', '🖖', '✍️', '👀', '🫶',
    ],
  ),
  (
    '❤️',
    'Сэтгэл',
    <String>[
      '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍', '💔', '💕', '💖', '💗', '💯', '✨', '⭐', '🌟', //
      '🔥', '🎉', '🎊', '✅', '❌', '❗', '❓', '💡', '⚠️',
    ],
  ),
  (
    '🏠',
    'Барилга',
    <String>[
      '🏠', '🏡', '🏘️', '🏗️', '🏢', '🧱', '🪵', '🪟', '🚪', '🛠️', '🔨', '🪚', '🔧', '🪛', '📐', '📏', //
      '🧰', '🎨', '🖌️', '🔌', '🚿', '🛁', '🚽', '🛏️', '🛋️', '🚚', '💰', '💳', '📞', '📅', '📷',
    ],
  ),
];

/// Inserts [emoji] at the cursor (or replaces the selection) in [controller].
void insertEmoji(TextEditingController controller, String emoji) {
  final String text = controller.text;
  final TextSelection selection = controller.selection;
  final int start = selection.isValid ? selection.start : text.length;
  final int end = selection.isValid ? selection.end : text.length;
  controller.value = TextEditingValue(
    text: text.replaceRange(start, end, emoji),
    selection: TextSelection.collapsed(offset: start + emoji.length),
  );
}

/// Bottom sheet with emoji tabs; stays open so several emoji can be added.
Future<void> showEmojiPickerSheet(BuildContext context, TextEditingController controller) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (BuildContext sheetContext) {
      return SafeArea(
        child: DefaultTabController(
          length: _emojiCategories.length,
          child: SizedBox(
            height: 300,
            child: Column(
              children: <Widget>[
                TabBar(
                  tabs: <Widget>[
                    for (final (String icon, String name, List<String> _) in _emojiCategories)
                      Tab(child: Semantics(label: name, child: Text(icon, style: const TextStyle(fontSize: 22)))),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      for (final (String _, String _, List<String> emojis) in _emojiCategories)
                        GridView.count(
                          crossAxisCount: 8,
                          padding: const EdgeInsets.all(8),
                          children: <Widget>[
                            for (final String emoji in emojis)
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () => insertEmoji(controller, emoji),
                                child: Center(child: Text(emoji, style: const TextStyle(fontSize: 26))),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
