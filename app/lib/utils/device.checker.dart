/*
  * Utility imports
 */
import 'package:flutter/foundation.dart';

// A class that checks the device type
class DeviceCheck {
  static final DeviceCheck _singleton = DeviceCheck._internal();
  factory DeviceCheck() {
    return _singleton;
  }
  DeviceCheck._internal();

  // Checks if the device is a Dekstop device
  bool get isDesktop =>
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows;

  // Checks if the device is a Mobile device
  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;
}
