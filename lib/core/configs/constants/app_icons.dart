import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_colors.dart';
import 'app_size.dart';

enum AppIcons {
  arrow_left(),
  back(),
  calling(),
  cart(),
  check(),
  chat(),
  choose(),
  document(),
  edit_profile(),
  email(),
  facebook(),
  folder_shield(),
  icon_add(),
  icon_pin(),
  image_placeholder(),
  list(),
  location(),
  logo(),
  menu_home(),
  menu_home_filled(),
  menu_idea(),
  menu_idea_filled(),
  menu_material(),
  menu_material_filled(),
  menu_profile(),
  payment_info(),
  payment_sucess(),
  pencil(),
  person(),
  search(),
  send(),
  share(),
  success_alert(),
  support_chat(),
  terms_and_conditions(),
  trash(),
  warning_alert();

  String get _path => 'assets/icons/$name.svg';

  Widget call({
    double size = AppSize.icon,
    Color color = AppColors.icon,
    bool applyColorFilter = false,
    String key = 'Key',
  }) {
    return SizedBox(
      key: ValueKey<String>(key),
      width: size,
      height: size,
      child: SvgPicture.asset(
        _path,
        fit: BoxFit.contain,
        colorFilter: switch (applyColorFilter) {
          true => ColorFilter.mode(color, BlendMode.srcIn),
          false => null,
        },
      ),
    );
  }
}
