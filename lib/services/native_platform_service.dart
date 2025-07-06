import 'package:flutter/services.dart';
import 'package:mzala/core/models/app_details.dart';
import 'package:mzala/core/initializer.dart';

abstract class NativePlatformService {
  Future<int?> getPlatformVersion();

  Future<AppDetails?> getPlatformAppDetails();

  Future<String?> getPackageName();

  Future<void> updateAssistLiveActivity({
    required DateTime? eta,
    required String? statusLine1,
    required String? statusLine2,
    required String? centerText,
    required String? bottomText,
  });

  Future<void> endAssistLiveActivity();
}

class NativePlatformServiceImplementation extends NativePlatformService {
  /// The method channel used to interact with the native platform.
  final _methodChannel = const MethodChannel('za.co.tihsa.oats_package');
  final _assistWidgetMethodChannel = const MethodChannel('za.co.tihsa.oats_package.assist_widget');

  @override
  Future<int?> getPlatformVersion() async => _methodChannel.invokeMethod<int>('getPlatformVersion');

  @override
  Future<AppDetails?> getPlatformAppDetails() async {
    final result = await _methodChannel.invokeMapMethod<String, dynamic>('getPlatformAppDetails');
    if (result != null) {
      return AppDetails.fromJson(result);
    }
    return null;
  }

  @override
  Future<String?> getPackageName() async => _methodChannel.invokeMethod<String>('getPackageName');

  @override
  Future<void> updateAssistLiveActivity({
    required DateTime? eta,
    required String? statusLine1,
    required String? statusLine2,
    required String? centerText,
    required String? bottomText,
  }) async {
    try {
      var brand = const String.fromEnvironment('Brand');
      var etaSinceEpoch = (eta?.millisecondsSinceEpoch ?? 0) / 1000;

      await _assistWidgetMethodChannel.invokeMethod('updateLiveActivity', {
        'brand': brand,
        'eta': eta != null ? etaSinceEpoch : null,
        'statusLine1': statusLine1,
        'statusLine2': statusLine2,
        'centerText': centerText,
        'bottomText': bottomText,
      });
    } catch (e, stackTrace) {
      // Logger.logException(e, stackTrace);
    }
  }

  @override
  Future<void> endAssistLiveActivity() async {
    try {
      await _assistWidgetMethodChannel.invokeMethod('endLiveActivity');
    } catch (e, stackTrace) {
      // Logger.logException(e, stackTrace);
    }
  }
}
