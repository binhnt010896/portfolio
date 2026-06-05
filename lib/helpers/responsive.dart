import 'package:flutter/widgets.dart';

/// Breakpoint-based responsive helpers (mobile / tablet / desktop).
///
/// Used everywhere instead of a third-party responsive package so the layout
/// rules live in one place.
enum DeviceType { mobile, tablet, desktop }

class Responsive {
  Responsive._();

  static const double mobileMaxWidth = 640;
  static const double tabletMaxWidth = 1024;

  /// Max content width on very large screens so text lines stay readable.
  static const double maxContentWidth = 1208;

  static DeviceType deviceType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width <= mobileMaxWidth) return DeviceType.mobile;
    if (width <= tabletMaxWidth) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      deviceType(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      deviceType(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      deviceType(context) == DeviceType.desktop;

  /// Horizontal page padding that grows with screen size.
  static double horizontalPadding(BuildContext context) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return 16;
      case DeviceType.tablet:
        return 48;
      case DeviceType.desktop:
        return 0; // desktop is centred with maxContentWidth instead
    }
  }

  /// Picks a value based on the current device type.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? desktop;
      case DeviceType.desktop:
        return desktop;
    }
  }
}

extension ResponsiveContext on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  DeviceType get deviceType => Responsive.deviceType(this);
}
