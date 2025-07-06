import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mzala/services/native_platform_service.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:mzala/core/initializer.dart';

class DeviceDetailsHelper {
  static final NativePlatformService _nativePlatformService = getService<NativePlatformService>();
  // static final GooglePlayService googlePlayService = getService<GooglePlayService>();
  // static final HuaweiService huaweiService = getService<HuaweiService>();

  /// Indicates whether the device has bottom padding.
  ///
  /// This variable is set to `true` if the device has bottom padding, which typically
  /// indicates that the device uses modern gesture-based navigation. It is set to `false`
  /// if there is no bottom padding, which typically indicates that the device has
  /// navigation buttons.
  static bool hasBottomPadding = false;

  static void initialize(BuildContext context) {
    hasBottomPadding = View.of(context).viewPadding.bottom != 0;
  }

  static Future<int> platformVersion() async => await _nativePlatformService.getPlatformVersion() ?? -1;

  static Future<bool> isRunningOnIosSimulator() async {
    var details = await _nativePlatformService.getPlatformAppDetails();
    return details?.devicePhoneModel == 'Simulator';
  }

  static Future<String?> appVersion() async => (await _nativePlatformService.getPlatformAppDetails())?.versionNumber;

  static Future<String?> manufacturer() async =>
      (await _nativePlatformService.getPlatformAppDetails())?.devicePhoneManufacturer;

  static Future<String?> operatingSystem() async => (await _nativePlatformService.getPlatformAppDetails())?.deviceOS;

  // static Future<bool> isGMSAvailable() async {
  //   if (Platform.isAndroid) {
  //     return await googlePlayService.checkPlayServices() == GooglePlayServicesAvailability.success;
  //   }

  //   return false;
  // }

  // static Future<bool> isHMSAvailable() async {
  //   if (Platform.isAndroid) {
  //     return await huaweiService.checkHmsServices() == HMSServicesAvailability.available;
  //   }

  //   return false;
  // }
}
