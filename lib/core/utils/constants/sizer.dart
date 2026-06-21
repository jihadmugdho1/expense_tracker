import 'package:flutter/material.dart';
import 'package:expensetracker/core/utils/constants/enums.dart';
import 'package:sizer/sizer.dart' show Device, ScreenType;

export 'package:sizer/sizer.dart' show Sizer, Device, ScreenType;

class AppSizer {
  AppSizer._();

  static const double designWidth = 360;
  static const double designHeight = 690;

  static const double mediumBreakpoint = 400;
  static const double largeBreakpoint = 600;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1024;

  static double get width => Device.width;
  static double get height => Device.height;
  static Orientation get orientation => Device.orientation;
  static bool get isPortrait => orientation == Orientation.portrait;
  static bool get isLandscape => orientation == Orientation.landscape;

  static double get widthRatio => width / designWidth;
  static double get heightRatio => height / designHeight;
  static double get minRatio =>
      widthRatio < heightRatio ? widthRatio : heightRatio;

  static AppDeviceType get deviceType {
    final shortest = width < height ? width : height;
    if (shortest >= tabletBreakpoint) return AppDeviceType.tablet;
    if (shortest >= largeBreakpoint) return AppDeviceType.large;
    if (shortest >= mediumBreakpoint) return AppDeviceType.medium;
    return AppDeviceType.small;
  }

  static bool get isSmall => deviceType == AppDeviceType.small;
  static bool get isMedium => deviceType == AppDeviceType.medium;
  static bool get isLarge => deviceType == AppDeviceType.large;
  static bool get isTablet => Device.screenType == ScreenType.tablet;
  static bool get isDesktop => Device.screenType == ScreenType.desktop;
  static bool get isMobile => Device.screenType == ScreenType.mobile;

  static T responsive<T>({required T small, T? medium, T? large, T? tablet}) {
    switch (deviceType) {
      case AppDeviceType.tablet:
        return tablet ?? large ?? medium ?? small;
      case AppDeviceType.large:
        return large ?? medium ?? small;
      case AppDeviceType.medium:
        return medium ?? small;
      case AppDeviceType.small:
        return small;
    }
  }

  static double deviceScale(num value) => responsive<double>(
    small: value.toDouble(),
    medium: value * 1.05,
    large: value * 1.12,
    tablet: value * 1.25,
  );

  static double fontDeviceScale(num value) => responsive<double>(
    small: value.toDouble(),
    medium: value * 1.03,
    large: value * 1.08,
    tablet: value * 1.15,
  );

  static EdgeInsets get pagePadding => EdgeInsets.symmetric(
    horizontal: responsive<double>(
      small: 16,
      medium: 20,
      large: 24,
      tablet: 32,
    ),
    vertical: responsive<double>(small: 12, medium: 16, large: 20, tablet: 24),
  );

  static int gridColumns({
    int small = 2,
    int medium = 2,
    int large = 3,
    int tablet = 4,
  }) => responsive<int>(
    small: small,
    medium: medium,
    large: large,
    tablet: tablet,
  );

  static double get maxContentWidth => responsive<double>(
    small: double.infinity,
    medium: double.infinity,
    large: 560,
    tablet: 720,
  );
}

/// flutter_screenutil-style design-pixel scaling against a 360 x 690 canvas.
extension DesignPixel on num {
  double get w => toDouble() * AppSizer.widthRatio;
  double get h => toDouble() * AppSizer.heightRatio;
  double get sp => toDouble() * AppSizer.widthRatio;
  double get r => toDouble() * AppSizer.minRatio;
}

/// Device-type aware scaling layered on top of design-pixel scaling.
extension ResponsivePixel on num {
  double get rw => AppSizer.deviceScale(toDouble() * AppSizer.widthRatio);
  double get rh => AppSizer.deviceScale(toDouble() * AppSizer.heightRatio);
  double get rsp => AppSizer.fontDeviceScale(toDouble() * AppSizer.widthRatio);
  double get rr => AppSizer.deviceScale(toDouble() * AppSizer.minRatio);
}

extension ResponsiveContext on BuildContext {
  AppDeviceType get deviceType => AppSizer.deviceType;
  bool get isSmall => AppSizer.isSmall;
  bool get isMedium => AppSizer.isMedium;
  bool get isLarge => AppSizer.isLarge;
  bool get isTablet => AppSizer.isTablet;
  bool get isMobile => AppSizer.isMobile;
  bool get isDesktop => AppSizer.isDesktop;
  bool get isPortrait => AppSizer.isPortrait;
  bool get isLandscape => AppSizer.isLandscape;
  double get screenWidth => AppSizer.width;
  double get screenHeight => AppSizer.height;

  T responsive<T>({required T small, T? medium, T? large, T? tablet}) =>
      AppSizer.responsive<T>(
        small: small,
        medium: medium,
        large: large,
        tablet: tablet,
      );
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.small,
    this.medium,
    this.large,
    this.tablet,
  });

  final WidgetBuilder small;
  final WidgetBuilder? medium;
  final WidgetBuilder? large;
  final WidgetBuilder? tablet;

  @override
  Widget build(BuildContext context) {
    switch (AppSizer.deviceType) {
      case AppDeviceType.tablet:
        return (tablet ?? large ?? medium ?? small)(context);
      case AppDeviceType.large:
        return (large ?? medium ?? small)(context);
      case AppDeviceType.medium:
        return (medium ?? small)(context);
      case AppDeviceType.small:
        return small(context);
    }
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.child,
    this.centerOnWide = true,
    this.maxWidth,
  });

  final Widget child;
  final bool centerOnWide;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final limit = maxWidth ?? AppSizer.maxContentWidth;
    if (!centerOnWide || limit == double.infinity) return child;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: limit),
        child: child,
      ),
    );
  }
}

class Gap extends StatelessWidget {
  const Gap(this.size, {super.key}) : _horizontal = false;
  const Gap.h(this.size, {super.key}) : _horizontal = true;

  final double size;
  final bool _horizontal;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: _horizontal ? size.w : null,
    height: _horizontal ? null : size.h,
  );
}
