import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppImageExt { svg, png }

// ignore_for_file: constant_identifier_names
enum AppImages {
  // chat
  chat_placeholder1('chat'),
  chat_placeholder2('chat'),
  chat_profile('chat'),
  support_chat('chat'),

  // floor_tiles/material
  laminat('floor_tiles/material'),
  normal_parket('floor_tiles/material'),

  // floor_tiles/type
  parket('floor_tiles/type'),
  ceramic('floor_tiles/type'),
  carpet('floor_tiles/type'),

  // fundament/material
  floor_houses('fundament/material'),
  houses_fundament('fundament/material'),

  // fundament/type
  pile_fundament('fundament/type'),
  concrete_fundament('fundament/type'),
  concrete_pile_fundament('fundament/type'),

  // home
  wall_description('home'),
  wall('home'),
  roof('home'),
  fundament('home'),
  inner_wall('home'),
  floor_tiles('home'),
  floor('home'),

  // idea
  idea_placeholder1('idea'),
  idea_placeholder2('idea'),
  idea_placeholder3('idea'),
  idea_placeholder4('idea'),
  idea_placeholder5('idea'),

  // inner-wall/material
  iron_frame('inner-wall/material'),
  wooden_frame('inner-wall/material'),

  // inner-wall/type
  gypsum_wall('inner-wall/type'),
  mak_block_inner_wall('inner-wall/type'),

  // login
  login_placeholder1('login'),
  login_placeholder2('login'),
  login_placeholder3('login'),
  login_placeholder4('login'),
  undraw_city_life_gnpr('login', ext: AppImageExt.svg),

  // material
  material_placeholder1('material'),
  material_placeholder2('material'),
  material_placeholder3('material'),
  material_placeholder4('material'),

  // onboarding
  onboarding1('onboarding'),
  onboarding2('onboarding'),
  onboarding3('onboarding'),

  // profile
  profile('profile'),

  // roof/material
  canada_house_roof_wooden('roof/material'),
  canada_house_type_roof('roof/material'),

  // roof/shape
  roof_shed_shape('roof/shape'),
  roof_triangle_shape('roof/shape'),
  roof_hip_shape('roof/shape'),

  // roof/type
  wooden_frame_roof('roof/type'),
  plate('roof/type'),
  metal_frame('roof/type'),
  concrete_roof('roof/type'),

  // roof/calculation
  concrete_iron_armature('roof/calculation'),

  // underfloor/material
  keramzit_and_concrete('underfloor/material'),
  basaltwool_and_wooden_frame('underfloor/material'),

  // underfloor/type
  canada_type('underfloor/type'),
  keramzit_and_concrete_type('underfloor/type'),

  // wall/type
  teplo_block('wall/type'),
  sandwich('wall/type'),
  polistrol_block('wall/type'),
  concrete_wall('wall/type'),
  mak_block('wall/type'),
  concrete_block('wall/type'),
  canada_house('wall/type'),
  brick('wall/type'),
  block_the_hole('wall/type'),

  // wall/wall-thickness
  wall_51cm('wall/wall-thickness'),
  wall_64cm('wall/wall-thickness'),
  wall_25cm('wall/wall-thickness'),
  wall_38cm('wall/wall-thickness'),
  wall_12cm('wall/wall-thickness'),

  // wall/material
  second_brick('wall/material'),

  standart_brick('wall'),

  // wall_decoration/material
  white_plaster('wall_decoration/material'),

  // wall_decoration/type
  stone('wall_decoration/type'),
  wall_paper('wall_decoration/type'),
  plaster('wall_decoration/type'),
  emulsion('wall_decoration/type'),
  paint('wall_decoration/type'),
  decoration_slab('wall_decoration/type'),

  //alert
  add_alert('alert'),
  payment_info_alert('alert'),
  payment_success_alert('alert'),
  success_alert('alert'),
  warning_alert('alert'),

  custom('app'),
  splash('app'),
  shape_stroke('app', ext: AppImageExt.svg);

  final String path;
  final AppImageExt ext;
  const AppImages(this.path, {this.ext = AppImageExt.png});

  // String get _path => switch (path.isEmpty) {
  //   true => 'assets/images/$name.${ext.name}',
  //   false => 'assets/images/${path.trim()}/$name.${ext.name}',
  // };

  String get _path => 'assets/images/${path.trim()}/$name.${ext.name}';

  Widget call({
    BoxFit? fit,
    Color? color,
    double? width,
    double? height,
  }) {
    return switch (ext) {
      AppImageExt.svg => SvgPicture.asset(
        _path,
        fit: fit ?? BoxFit.contain,
        width: width,
        height: height,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      ),
      AppImageExt.png => Image.asset(
        _path,
        fit: fit ?? BoxFit.contain,
        width: width,
        height: height,
        //color: color,
      ),
    };
  }
}
