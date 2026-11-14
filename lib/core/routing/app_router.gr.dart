// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CalculationHistoryScreenView]
class CalculationHistoryScreenRoute
    extends PageRouteInfo<CalculationHistoryScreenRouteArgs> {
  CalculationHistoryScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         CalculationHistoryScreenRoute.name,
         args: CalculationHistoryScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'CalculationHistoryScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CalculationHistoryScreenRouteArgs>(
        orElse: () => const CalculationHistoryScreenRouteArgs(),
      );
      return CalculationHistoryScreenView(key: args.key, args: args.args);
    },
  );
}

class CalculationHistoryScreenRouteArgs {
  const CalculationHistoryScreenRouteArgs({
    this.key,
    this.args = const DefaultScreenArgs(),
  });

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'CalculationHistoryScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CalculationHistoryScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [CalculationScreenView]
class CalculationScreenRoute extends PageRouteInfo<CalculationScreenRouteArgs> {
  CalculationScreenRoute({
    Key? key,
    required CalculationScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         CalculationScreenRoute.name,
         args: CalculationScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'CalculationScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CalculationScreenRouteArgs>();
      return CalculationScreenView(key: args.key, args: args.args);
    },
  );
}

class CalculationScreenRouteArgs {
  const CalculationScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final CalculationScreenArgs args;

  @override
  String toString() {
    return 'CalculationScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CalculationScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [ChatbotAnonymousScreenView]
class ChatbotAnonymousScreenRoute
    extends PageRouteInfo<ChatbotAnonymousScreenRouteArgs> {
  ChatbotAnonymousScreenRoute({
    Key? key,
    ChatbotAnonymousScreenArgs args = const ChatbotAnonymousScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         ChatbotAnonymousScreenRoute.name,
         args: ChatbotAnonymousScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'ChatbotAnonymousScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatbotAnonymousScreenRouteArgs>(
        orElse: () => const ChatbotAnonymousScreenRouteArgs(),
      );
      return ChatbotAnonymousScreenView(key: args.key, args: args.args);
    },
  );
}

class ChatbotAnonymousScreenRouteArgs {
  const ChatbotAnonymousScreenRouteArgs({
    this.key,
    this.args = const ChatbotAnonymousScreenArgs(),
  });

  final Key? key;

  final ChatbotAnonymousScreenArgs args;

  @override
  String toString() {
    return 'ChatbotAnonymousScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatbotAnonymousScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [ChatbotScreenView]
class ChatbotScreenRoute extends PageRouteInfo<ChatbotScreenRouteArgs> {
  ChatbotScreenRoute({
    Key? key,
    ChatbotScreenArgs args = const ChatbotScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         ChatbotScreenRoute.name,
         args: ChatbotScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'ChatbotScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatbotScreenRouteArgs>(
        orElse: () => const ChatbotScreenRouteArgs(),
      );
      return ChatbotScreenView(key: args.key, args: args.args);
    },
  );
}

class ChatbotScreenRouteArgs {
  const ChatbotScreenRouteArgs({
    this.key,
    this.args = const ChatbotScreenArgs(),
  });

  final Key? key;

  final ChatbotScreenArgs args;

  @override
  String toString() {
    return 'ChatbotScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatbotScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [ContactUsScreenView]
class ContactUsScreenRoute extends PageRouteInfo<void> {
  const ContactUsScreenRoute({List<PageRouteInfo>? children})
    : super(ContactUsScreenRoute.name, initialChildren: children);

  static const String name = 'ContactUsScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactUsScreenView();
    },
  );
}

/// generated route for
/// [CustomChooseMaterialScreenView]
class CustomChooseMaterialScreenRoute
    extends PageRouteInfo<CustomChooseMaterialScreenRouteArgs> {
  CustomChooseMaterialScreenRoute({
    Key? key,
    required ChooseMaterialScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         CustomChooseMaterialScreenRoute.name,
         args: CustomChooseMaterialScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'CustomChooseMaterialScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomChooseMaterialScreenRouteArgs>();
      return CustomChooseMaterialScreenView(key: args.key, args: args.args);
    },
  );
}

class CustomChooseMaterialScreenRouteArgs {
  const CustomChooseMaterialScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final ChooseMaterialScreenArgs args;

  @override
  String toString() {
    return 'CustomChooseMaterialScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomChooseMaterialScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [CustomChooseShapesScreenView]
class CustomChooseShapesScreenRoute
    extends PageRouteInfo<CustomChooseShapesScreenRouteArgs> {
  CustomChooseShapesScreenRoute({
    Key? key,
    required ChooseShapesScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         CustomChooseShapesScreenRoute.name,
         args: CustomChooseShapesScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'CustomChooseShapesScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomChooseShapesScreenRouteArgs>();
      return CustomChooseShapesScreenView(key: args.key, args: args.args);
    },
  );
}

class CustomChooseShapesScreenRouteArgs {
  const CustomChooseShapesScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final ChooseShapesScreenArgs args;

  @override
  String toString() {
    return 'CustomChooseShapesScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomChooseShapesScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [CustomChooseThicknessScreenView]
class CustomChooseThicknessScreenRoute
    extends PageRouteInfo<CustomChooseThicknessScreenRouteArgs> {
  CustomChooseThicknessScreenRoute({
    Key? key,
    required ChooseThicknessScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         CustomChooseThicknessScreenRoute.name,
         args: CustomChooseThicknessScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'CustomChooseThicknessScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomChooseThicknessScreenRouteArgs>();
      return CustomChooseThicknessScreenView(key: args.key, args: args.args);
    },
  );
}

class CustomChooseThicknessScreenRouteArgs {
  const CustomChooseThicknessScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final ChooseThicknessScreenArgs args;

  @override
  String toString() {
    return 'CustomChooseThicknessScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomChooseThicknessScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [CustomChooseTypeScreenView]
class CustomChooseTypeScreenRoute
    extends PageRouteInfo<CustomChooseTypeScreenRouteArgs> {
  CustomChooseTypeScreenRoute({
    Key? key,
    required ChooseTypeScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         CustomChooseTypeScreenRoute.name,
         args: CustomChooseTypeScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'CustomChooseTypeScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomChooseTypeScreenRouteArgs>();
      return CustomChooseTypeScreenView(key: args.key, args: args.args);
    },
  );
}

class CustomChooseTypeScreenRouteArgs {
  const CustomChooseTypeScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final ChooseTypeScreenArgs args;

  @override
  String toString() {
    return 'CustomChooseTypeScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomChooseTypeScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [DashboardScreenView]
class DashboardScreenRoute extends PageRouteInfo<DashboardScreenRouteArgs> {
  DashboardScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         DashboardScreenRoute.name,
         args: DashboardScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'DashboardScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DashboardScreenRouteArgs>(
        orElse: () => const DashboardScreenRouteArgs(),
      );
      return DashboardScreenView(key: args.key, args: args.args);
    },
  );
}

class DashboardScreenRouteArgs {
  const DashboardScreenRouteArgs({
    this.key,
    this.args = const DefaultScreenArgs(),
  });

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'DashboardScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DashboardScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [DevelopmentModeScreenView]
class DevelopmentModeScreenRoute extends PageRouteInfo<void> {
  const DevelopmentModeScreenRoute({List<PageRouteInfo>? children})
    : super(DevelopmentModeScreenRoute.name, initialChildren: children);

  static const String name = 'DevelopmentModeScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DevelopmentModeScreenView();
    },
  );
}

/// generated route for
/// [EditProfileScreenView]
class EditProfileScreenRoute extends PageRouteInfo<EditProfileScreenRouteArgs> {
  EditProfileScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         EditProfileScreenRoute.name,
         args: EditProfileScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'EditProfileScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileScreenRouteArgs>(
        orElse: () => const EditProfileScreenRouteArgs(),
      );
      return EditProfileScreenView(key: args.key, args: args.args);
    },
  );
}

class EditProfileScreenRouteArgs {
  const EditProfileScreenRouteArgs({
    this.key,
    this.args = const DefaultScreenArgs(),
  });

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'EditProfileScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditProfileScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [FloorTilesEstimationScreenView]
class FloorTilesEstimationScreenRoute
    extends PageRouteInfo<FloorTilesEstimationScreenRouteArgs> {
  FloorTilesEstimationScreenRoute({
    Key? key,
    required DefaultScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         FloorTilesEstimationScreenRoute.name,
         args: FloorTilesEstimationScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'FloorTilesEstimationScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FloorTilesEstimationScreenRouteArgs>();
      return FloorTilesEstimationScreenView(key: args.key, args: args.args);
    },
  );
}

class FloorTilesEstimationScreenRouteArgs {
  const FloorTilesEstimationScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'FloorTilesEstimationScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FloorTilesEstimationScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [FundamentEstimationScreenView]
class FundamentEstimationScreenRoute
    extends PageRouteInfo<FundamentEstimationScreenRouteArgs> {
  FundamentEstimationScreenRoute({
    Key? key,
    required DefaultScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         FundamentEstimationScreenRoute.name,
         args: FundamentEstimationScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'FundamentEstimationScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FundamentEstimationScreenRouteArgs>();
      return FundamentEstimationScreenView(key: args.key, args: args.args);
    },
  );
}

class FundamentEstimationScreenRouteArgs {
  const FundamentEstimationScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'FundamentEstimationScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FundamentEstimationScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [HomeScreenView]
class HomeScreenRoute extends PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         HomeScreenRoute.name,
         args: HomeScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'HomeScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeScreenRouteArgs>(
        orElse: () => const HomeScreenRouteArgs(),
      );
      return HomeScreenView(key: args.key, args: args.args);
    },
  );
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.key, this.args = const DefaultScreenArgs()});

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'HomeScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [HomeScreenWrapperView]
class HomeScreenWrapperRoute extends PageRouteInfo<HomeScreenWrapperRouteArgs> {
  HomeScreenWrapperRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        HomeScreenWrapperRoute.name,
        args: HomeScreenWrapperRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'HomeScreenWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeScreenWrapperRouteArgs>(
        orElse: () => const HomeScreenWrapperRouteArgs(),
      );
      return HomeScreenWrapperView(key: args.key);
    },
  );
}

class HomeScreenWrapperRouteArgs {
  const HomeScreenWrapperRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeScreenWrapperRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeScreenWrapperRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [IdeaDetailScreenView]
class IdeaDetailScreenRoute extends PageRouteInfo<IdeaDetailScreenRouteArgs> {
  IdeaDetailScreenRoute({
    Key? key,
    required IdeaDetailScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         IdeaDetailScreenRoute.name,
         args: IdeaDetailScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'IdeaDetailScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IdeaDetailScreenRouteArgs>();
      return IdeaDetailScreenView(key: args.key, args: args.args);
    },
  );
}

class IdeaDetailScreenRouteArgs {
  const IdeaDetailScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final IdeaDetailScreenArgs args;

  @override
  String toString() {
    return 'IdeaDetailScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! IdeaDetailScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [IdeaListScreenView]
class IdeaListScreenRoute extends PageRouteInfo<IdeaListScreenRouteArgs> {
  IdeaListScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         IdeaListScreenRoute.name,
         args: IdeaListScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'IdeaListScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IdeaListScreenRouteArgs>(
        orElse: () => const IdeaListScreenRouteArgs(),
      );
      return IdeaListScreenView(key: args.key, args: args.args);
    },
  );
}

class IdeaListScreenRouteArgs {
  const IdeaListScreenRouteArgs({
    this.key,
    this.args = const DefaultScreenArgs(),
  });

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'IdeaListScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! IdeaListScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [IdeaScreenWrapperView]
class IdeaScreenWrapperRoute extends PageRouteInfo<IdeaScreenWrapperRouteArgs> {
  IdeaScreenWrapperRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        IdeaScreenWrapperRoute.name,
        args: IdeaScreenWrapperRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'IdeaScreenWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IdeaScreenWrapperRouteArgs>(
        orElse: () => const IdeaScreenWrapperRouteArgs(),
      );
      return IdeaScreenWrapperView(key: args.key);
    },
  );
}

class IdeaScreenWrapperRouteArgs {
  const IdeaScreenWrapperRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'IdeaScreenWrapperRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! IdeaScreenWrapperRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [ImagePickerScreenView]
class ImagePickerScreenRoute extends PageRouteInfo<ImagePickerScreenRouteArgs> {
  ImagePickerScreenRoute({
    Key? key,
    required ImagePickerScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         ImagePickerScreenRoute.name,
         args: ImagePickerScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'ImagePickerScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ImagePickerScreenRouteArgs>();
      return ImagePickerScreenView(key: args.key, args: args.args);
    },
  );
}

class ImagePickerScreenRouteArgs {
  const ImagePickerScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final ImagePickerScreenArgs args;

  @override
  String toString() {
    return 'ImagePickerScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ImagePickerScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [InnerWallEstimationScreenView]
class InnerWallEstimationScreenRoute
    extends PageRouteInfo<InnerWallEstimationScreenRouteArgs> {
  InnerWallEstimationScreenRoute({
    Key? key,
    required DefaultScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         InnerWallEstimationScreenRoute.name,
         args: InnerWallEstimationScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'InnerWallEstimationScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InnerWallEstimationScreenRouteArgs>();
      return InnerWallEstimationScreenView(key: args.key, args: args.args);
    },
  );
}

class InnerWallEstimationScreenRouteArgs {
  const InnerWallEstimationScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'InnerWallEstimationScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InnerWallEstimationScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [LoginOptionScreenView]
class LoginOptionScreenRoute extends PageRouteInfo<void> {
  const LoginOptionScreenRoute({List<PageRouteInfo>? children})
    : super(LoginOptionScreenRoute.name, initialChildren: children);

  static const String name = 'LoginOptionScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginOptionScreenView();
    },
  );
}

/// generated route for
/// [LoginPasswordScreenView]
class LoginPasswordScreenRoute
    extends PageRouteInfo<LoginPasswordScreenRouteArgs> {
  LoginPasswordScreenRoute({
    Key? key,
    required AuthScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         LoginPasswordScreenRoute.name,
         args: LoginPasswordScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'LoginPasswordScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginPasswordScreenRouteArgs>();
      return LoginPasswordScreenView(key: args.key, args: args.args);
    },
  );
}

class LoginPasswordScreenRouteArgs {
  const LoginPasswordScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final AuthScreenArgs args;

  @override
  String toString() {
    return 'LoginPasswordScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginPasswordScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [LoginPhoneNumberScreenView]
class LoginPhoneNumberScreenRoute
    extends PageRouteInfo<LoginPhoneNumberScreenRouteArgs> {
  LoginPhoneNumberScreenRoute({
    Key? key,
    required AuthScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         LoginPhoneNumberScreenRoute.name,
         args: LoginPhoneNumberScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'LoginPhoneNumberScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginPhoneNumberScreenRouteArgs>();
      return LoginPhoneNumberScreenView(key: args.key, args: args.args);
    },
  );
}

class LoginPhoneNumberScreenRouteArgs {
  const LoginPhoneNumberScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final AuthScreenArgs args;

  @override
  String toString() {
    return 'LoginPhoneNumberScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginPhoneNumberScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [LoginUserNameScreenView]
class LoginUserNameScreenRoute
    extends PageRouteInfo<LoginUserNameScreenRouteArgs> {
  LoginUserNameScreenRoute({
    Key? key,
    required AuthScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         LoginUserNameScreenRoute.name,
         args: LoginUserNameScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'LoginUserNameScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginUserNameScreenRouteArgs>();
      return LoginUserNameScreenView(key: args.key, args: args.args);
    },
  );
}

class LoginUserNameScreenRouteArgs {
  const LoginUserNameScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final AuthScreenArgs args;

  @override
  String toString() {
    return 'LoginUserNameScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginUserNameScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [MaterialListScreenView]
class MaterialListScreenRoute
    extends PageRouteInfo<MaterialListScreenRouteArgs> {
  MaterialListScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         MaterialListScreenRoute.name,
         args: MaterialListScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'MaterialListScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MaterialListScreenRouteArgs>(
        orElse: () => const MaterialListScreenRouteArgs(),
      );
      return MaterialListScreenView(key: args.key, args: args.args);
    },
  );
}

class MaterialListScreenRouteArgs {
  const MaterialListScreenRouteArgs({
    this.key,
    this.args = const DefaultScreenArgs(),
  });

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'MaterialListScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MaterialListScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [MaterialScreenWrapperView]
class MaterialScreenWrapperRoute
    extends PageRouteInfo<MaterialScreenWrapperRouteArgs> {
  MaterialScreenWrapperRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        MaterialScreenWrapperRoute.name,
        args: MaterialScreenWrapperRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'MaterialScreenWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MaterialScreenWrapperRouteArgs>(
        orElse: () => const MaterialScreenWrapperRouteArgs(),
      );
      return MaterialScreenWrapperView(key: args.key);
    },
  );
}

class MaterialScreenWrapperRouteArgs {
  const MaterialScreenWrapperRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MaterialScreenWrapperRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MaterialScreenWrapperRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [MembershipExpiredView]
class MembershipExpiredRoute extends PageRouteInfo<void> {
  const MembershipExpiredRoute({List<PageRouteInfo>? children})
    : super(MembershipExpiredRoute.name, initialChildren: children);

  static const String name = 'MembershipExpiredRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MembershipExpiredView();
    },
  );
}

/// generated route for
/// [OnboardingScreenView]
class OnboardingScreenRoute extends PageRouteInfo<void> {
  const OnboardingScreenRoute({List<PageRouteInfo>? children})
    : super(OnboardingScreenRoute.name, initialChildren: children);

  static const String name = 'OnboardingScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreenView();
    },
  );
}

/// generated route for
/// [PrivacyPolicyView]
class PrivacyPolicyRoute extends PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PrivacyPolicyView();
    },
  );
}

/// generated route for
/// [ProfileScreenView]
class ProfileScreenRoute extends PageRouteInfo<ProfileScreenRouteArgs> {
  ProfileScreenRoute({
    Key? key,
    required ProfileScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         ProfileScreenRoute.name,
         args: ProfileScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'ProfileScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileScreenRouteArgs>();
      return ProfileScreenView(key: args.key, args: args.args);
    },
  );
}

class ProfileScreenRouteArgs {
  const ProfileScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final ProfileScreenArgs args;

  @override
  String toString() {
    return 'ProfileScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [ProfileScreenWrapperView]
class ProfileScreenWrapperRoute
    extends PageRouteInfo<ProfileScreenWrapperRouteArgs> {
  ProfileScreenWrapperRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        ProfileScreenWrapperRoute.name,
        args: ProfileScreenWrapperRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ProfileScreenWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileScreenWrapperRouteArgs>(
        orElse: () => const ProfileScreenWrapperRouteArgs(),
      );
      return ProfileScreenWrapperView(key: args.key);
    },
  );
}

class ProfileScreenWrapperRouteArgs {
  const ProfileScreenWrapperRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ProfileScreenWrapperRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileScreenWrapperRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [PurchaseMembershipScreenView]
class PurchaseMembershipScreenRoute
    extends PageRouteInfo<PurchaseMembershipScreenRouteArgs> {
  PurchaseMembershipScreenRoute({
    required int balance,
    required SubscriptionsResponseModel? subscriptionModel,
    required RechargeScreenArgs rechargeScreenArgs,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         PurchaseMembershipScreenRoute.name,
         args: PurchaseMembershipScreenRouteArgs(
           balance: balance,
           subscriptionModel: subscriptionModel,
           rechargeScreenArgs: rechargeScreenArgs,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'PurchaseMembershipScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PurchaseMembershipScreenRouteArgs>();
      return PurchaseMembershipScreenView(
        balance: args.balance,
        subscriptionModel: args.subscriptionModel,
        rechargeScreenArgs: args.rechargeScreenArgs,
        key: args.key,
      );
    },
  );
}

class PurchaseMembershipScreenRouteArgs {
  const PurchaseMembershipScreenRouteArgs({
    required this.balance,
    required this.subscriptionModel,
    required this.rechargeScreenArgs,
    this.key,
  });

  final int balance;

  final SubscriptionsResponseModel? subscriptionModel;

  final RechargeScreenArgs rechargeScreenArgs;

  final Key? key;

  @override
  String toString() {
    return 'PurchaseMembershipScreenRouteArgs{balance: $balance, subscriptionModel: $subscriptionModel, rechargeScreenArgs: $rechargeScreenArgs, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PurchaseMembershipScreenRouteArgs) return false;
    return balance == other.balance &&
        subscriptionModel == other.subscriptionModel &&
        rechargeScreenArgs == other.rechargeScreenArgs &&
        key == other.key;
  }

  @override
  int get hashCode =>
      balance.hashCode ^
      subscriptionModel.hashCode ^
      rechargeScreenArgs.hashCode ^
      key.hashCode;
}

/// generated route for
/// [PurchasedHistoryScreenView]
class PurchasedHistoryScreenRoute
    extends PageRouteInfo<PurchasedHistoryScreenRouteArgs> {
  PurchasedHistoryScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         PurchasedHistoryScreenRoute.name,
         args: PurchasedHistoryScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'PurchasedHistoryScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PurchasedHistoryScreenRouteArgs>(
        orElse: () => const PurchasedHistoryScreenRouteArgs(),
      );
      return PurchasedHistoryScreenView(key: args.key, args: args.args);
    },
  );
}

class PurchasedHistoryScreenRouteArgs {
  const PurchasedHistoryScreenRouteArgs({
    this.key,
    this.args = const DefaultScreenArgs(),
  });

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'PurchasedHistoryScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PurchasedHistoryScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [RechargeScreenView]
class RechargeScreenRoute extends PageRouteInfo<RechargeScreenRouteArgs> {
  RechargeScreenRoute({
    Key? key,
    required RechargeScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         RechargeScreenRoute.name,
         args: RechargeScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'RechargeScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RechargeScreenRouteArgs>();
      return RechargeScreenView(key: args.key, args: args.args);
    },
  );
}

class RechargeScreenRouteArgs {
  const RechargeScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final RechargeScreenArgs args;

  @override
  String toString() {
    return 'RechargeScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RechargeScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [RoofEstimationScreenView]
class RoofEstimationScreenRoute
    extends PageRouteInfo<RoofEstimationScreenRouteArgs> {
  RoofEstimationScreenRoute({
    Key? key,
    required DefaultScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         RoofEstimationScreenRoute.name,
         args: RoofEstimationScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'RoofEstimationScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RoofEstimationScreenRouteArgs>();
      return RoofEstimationScreenView(key: args.key, args: args.args);
    },
  );
}

class RoofEstimationScreenRouteArgs {
  const RoofEstimationScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'RoofEstimationScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RoofEstimationScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [SplashScreenView]
class SplashScreenRoute extends PageRouteInfo<SplashScreenRouteArgs> {
  SplashScreenRoute({
    Key? key,
    DefaultScreenArgs args = const DefaultScreenArgs(),
    List<PageRouteInfo>? children,
  }) : super(
         SplashScreenRoute.name,
         args: SplashScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'SplashScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashScreenRouteArgs>(
        orElse: () => const SplashScreenRouteArgs(),
      );
      return SplashScreenView(key: args.key, args: args.args);
    },
  );
}

class SplashScreenRouteArgs {
  const SplashScreenRouteArgs({
    this.key,
    this.args = const DefaultScreenArgs(),
  });

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'SplashScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SplashScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [TermsAndConditionsScreenView]
class TermsAndConditionsScreenRoute extends PageRouteInfo<void> {
  const TermsAndConditionsScreenRoute({List<PageRouteInfo>? children})
    : super(TermsAndConditionsScreenRoute.name, initialChildren: children);

  static const String name = 'TermsAndConditionsScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TermsAndConditionsScreenView();
    },
  );
}

/// generated route for
/// [UnderfloorEstimationScreenView]
class UnderfloorEstimationScreenRoute
    extends PageRouteInfo<UnderfloorEstimationScreenRouteArgs> {
  UnderfloorEstimationScreenRoute({
    Key? key,
    required DefaultScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         UnderfloorEstimationScreenRoute.name,
         args: UnderfloorEstimationScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'UnderfloorEstimationScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UnderfloorEstimationScreenRouteArgs>();
      return UnderfloorEstimationScreenView(key: args.key, args: args.args);
    },
  );
}

class UnderfloorEstimationScreenRouteArgs {
  const UnderfloorEstimationScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'UnderfloorEstimationScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UnderfloorEstimationScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [WallDecorationEstimationScreenView]
class WallDecorationEstimationScreenRoute
    extends PageRouteInfo<WallDecorationEstimationScreenRouteArgs> {
  WallDecorationEstimationScreenRoute({
    Key? key,
    required DefaultScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         WallDecorationEstimationScreenRoute.name,
         args: WallDecorationEstimationScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'WallDecorationEstimationScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WallDecorationEstimationScreenRouteArgs>();
      return WallDecorationEstimationScreenView(key: args.key, args: args.args);
    },
  );
}

class WallDecorationEstimationScreenRouteArgs {
  const WallDecorationEstimationScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'WallDecorationEstimationScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WallDecorationEstimationScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}

/// generated route for
/// [WallEstimationScreenView]
class WallEstimationScreenRoute
    extends PageRouteInfo<WallEstimationScreenRouteArgs> {
  WallEstimationScreenRoute({
    Key? key,
    required DefaultScreenArgs args,
    List<PageRouteInfo>? children,
  }) : super(
         WallEstimationScreenRoute.name,
         args: WallEstimationScreenRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'WallEstimationScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WallEstimationScreenRouteArgs>();
      return WallEstimationScreenView(key: args.key, args: args.args);
    },
  );
}

class WallEstimationScreenRouteArgs {
  const WallEstimationScreenRouteArgs({this.key, required this.args});

  final Key? key;

  final DefaultScreenArgs args;

  @override
  String toString() {
    return 'WallEstimationScreenRouteArgs{key: $key, args: $args}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WallEstimationScreenRouteArgs) return false;
    return key == other.key && args == other.args;
  }

  @override
  int get hashCode => key.hashCode ^ args.hashCode;
}
