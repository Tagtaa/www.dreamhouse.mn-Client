import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/calculation/door_window_model.dart';

class DoorWindowItemView extends StatelessWidget {
  final int index;
  final DoorWindowModel item;
  final VoidCallback onDelete;
  final bool isWindow;

  const DoorWindowItemView({
    super.key,
    required this.index,
    required this.item,
    required this.onDelete,
    this.isWindow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.radiusLow),
        color: AppColors.secondaryBackground,
      ),
      child: ListTile(
        leading: Icon(
          isWindow ? Icons.window : Icons.door_back_door,
          color: isWindow ? Colors.blueAccent : Colors.brown,
        ),
        title: Text(
          '${isWindow ? TextConstants.window : TextConstants.door} ${index + 1}',
          style: AppTextStyles.labelMedium(),
        ),
        subtitle: Text(
          '${TextConstants.width}: ${item.width} cm   |   ${TextConstants.length}: ${item.height} ${TextConstants.cm}',
          style: AppTextStyles.labelMedium(fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
