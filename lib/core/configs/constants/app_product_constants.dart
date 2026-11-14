import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../../ui/screens/base_screen_args.dart';
import '../../routing/app_router.dart';
import 'app_icons.dart';
import 'app_images.dart';
import 'text_constants.dart';

class AppProductConstants {
  static List<Map<String, dynamic>> menuIconLists = <Map<String, dynamic>>[
    <String, dynamic>{
      'outline': AppIcons.menu_home,
      'filled': AppIcons.menu_home_filled,
    },
    <String, dynamic>{
      'outline': AppIcons.menu_idea,
      'filled': AppIcons.menu_idea_filled,
    },
    <String, dynamic>{
      'outline': AppIcons.menu_material,
      'filled': AppIcons.menu_material_filled,
    },
    <String, dynamic>{
      'outline': AppIcons.menu_profile,
      'filled': AppIcons.menu_profile,
    },
  ];

  static List<AppImages> wallEstimationImageList = <AppImages>[
    AppImages.wall,
    AppImages.fundament,
    AppImages.roof,
    AppImages.inner_wall,
    AppImages.floor,
    AppImages.floor_tiles,
    AppImages.wall_description,
  ];

  static List<PageRouteInfo> wallEstimationRouteLists = <PageRouteInfo>[
    WallEstimationScreenRoute(args: const DefaultScreenArgs()),
    FundamentEstimationScreenRoute(args: const DefaultScreenArgs()),
    RoofEstimationScreenRoute(args: const DefaultScreenArgs()),
    InnerWallEstimationScreenRoute(args: const DefaultScreenArgs()),
    UnderfloorEstimationScreenRoute(args: const DefaultScreenArgs()),
    FloorTilesEstimationScreenRoute(args: const DefaultScreenArgs()),
    WallDecorationEstimationScreenRoute(args: const DefaultScreenArgs()),
  ];

  static const List<String> wallEstimationTitles = TextConstants.wallEstimationTitles;

  static List<AppImages> wallChooseTypeList = <AppImages>[
    AppImages.brick,
    AppImages.block_the_hole,
    AppImages.sandwich,
    AppImages.mak_block,
    AppImages.concrete_block,
    AppImages.polistrol_block,
    AppImages.teplo_block,
    AppImages.canada_house,
    AppImages.concrete_wall,
    AppImages.custom,
  ];

  static const List<String> wallChooseTypeTitles = TextConstants.wallChooseTypeTitles;

  static List<AppImages> wallChooseMaterialList = <AppImages>[
    AppImages.second_brick,
    AppImages.standart_brick,
  ];

  static const List<String> wallChooseMaterialTitles = TextConstants.wallChooseMaterialTitles;

  static List<AppImages> wallChooseThicknessList = <AppImages>[
    AppImages.wall_38cm,
    AppImages.wall_25cm,
    AppImages.wall_12cm,
    AppImages.wall_51cm,
    AppImages.wall_64cm,
  ];

  static List<String> wallThicknessTitles = <String>[
    '38cm',
    '25cm',
    '12cm',
    '51cm',
    '64cm',
  ];

  ///Fundament
  static List<AppImages> fundamentChooseTypeList = <AppImages>[
    AppImages.concrete_fundament,
    AppImages.pile_fundament,
    AppImages.concrete_pile_fundament,
  ];

  static List<String> fundamentChooseTypeTitles = TextConstants.fundamentChooseTypeTitles;

  static List<AppImages> fundamentChooseMaterialList = <AppImages>[
    AppImages.floor_houses,
    AppImages.houses_fundament,
  ];

  static List<String> fundamentChooseMaterialTitles = <String>[
    'Standard beton for small houses fundament',
    'Beton for 2-5 floor houses',
  ];

  static List<AppImages> roofChooseTypeList = <AppImages>[
    AppImages.concrete_roof,
    AppImages.metal_frame,
    AppImages.plate,
    AppImages.wooden_frame_roof,
  ];

  static List<String> roofChooseTypeTitles = TextConstants.roofChooseTypeTitles;

  static List<AppImages> roofChooseMaterialList = <AppImages>[
    AppImages.canada_house_roof_wooden,
    AppImages.houses_fundament,
  ];

  static List<String> roofChooseMaterialTitles = TextConstants.roofChooseMaterialTitles;

  static List<Widget> roofWoodenFrameCalculationList = <Widget>[
    AppImages.concrete_iron_armature(),
    AppImages.canada_house_type_roof(),
  ];

  static List<Widget> roofBrickCalculationList = <Widget>[
    AppImages.concrete_iron_armature(),
    AppImages.plate(),
  ];

  static List<AppImages> roofShapeList = <AppImages>[
    AppImages.roof_hip_shape,
    AppImages.roof_shed_shape,
    AppImages.roof_triangle_shape,
  ];
  static List<String> roofShapeTitles = TextConstants.roofShapeTitles;

  static List<AppImages> innerWallChooseTypeList = <AppImages>[
    AppImages.gypsum_wall,
    AppImages.mak_block_inner_wall,
    AppImages.custom,
  ];

  static List<String> innerWallChooseTypeTitles = TextConstants.innerWallChooseTypeTitles;

  static List<AppImages> innerWallChooseMaterialList = <AppImages>[
    AppImages.wooden_frame,
    AppImages.iron_frame,
  ];

  static List<String> innerWallChooseMaterialTitles = TextConstants.innerWallChooseMaterialTitles;

  static List<AppImages> underFloorChooseTypeList = <AppImages>[
    AppImages.canada_type,
    AppImages.keramzit_and_concrete_type,
    AppImages.custom,
  ];

  static List<String> underFloorChooseTypeTitles = TextConstants.underFloorChooseTypeTitles;

  static List<AppImages> underFloorChooseMaterialList = <AppImages>[
    AppImages.basaltwool_and_wooden_frame,
    AppImages.keramzit_and_concrete,
  ];

  static List<String> underFloorChooseMaterialTitles = <String>[
    'Basaltwool and wooden frame',
    'Keramzit and concrete',
  ];

  static List<AppImages> floorChooseTypeList = <AppImages>[
    AppImages.parket,
    AppImages.ceramic,
    AppImages.carpet,
    AppImages.custom,
  ];

  static List<String> floorChooseTypeTitles = TextConstants.floorChooseTypeTitles;

  static List<AppImages> floorChooseMaterialList = <AppImages>[
    AppImages.normal_parket,
    AppImages.laminat,
  ];

  static List<String> floorChooseMaterialTitles = TextConstants.floorChooseMaterialTitles;

  static List<Widget> floorCalculateList = <Widget>[
    AppImages.parket(),
    AppImages.normal_parket(),
  ];

  static List<Widget> floorCustomCalculateList = <Widget>[
    AppImages.custom(),
    AppImages.custom(),
  ];

  static List<AppImages> wallDecorationChooseTypeList = <AppImages>[
    AppImages.plaster,
    AppImages.wall_paper,
    AppImages.emulsion,
    AppImages.paint,
    AppImages.decoration_slab,
    AppImages.stone,
  ];

  static List<String> wallDecorationChooseTypeTitles = TextConstants.wallDecorationChooseTypeTitles;

  static List<AppImages> wallDecorationChooseMaterialList = <AppImages>[
    AppImages.white_plaster,
  ];

  static List<String> wallDecorationChooseMaterialTitles = TextConstants.wallDecorationChooseMaterialTitles;
}
