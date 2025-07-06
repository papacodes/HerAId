import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:oats_package/data/models/audit/audit_event_feature.dart';
import 'package:oats_package/data/models/audit/audit_page_detail.dart';
import 'package:oats_package/data/models/realm/content/burgerMenu/realm_settings_view_content.dart';
import 'package:oats_package/data/models/realm/content/generic/realm_biometrics_prompts_content.dart';
import 'package:oats_package/data/models/realm/content/generic/realm_popups_content.dart';
import 'package:oats_package/data/models/realm/settings/realm_settings_data.dart';
import 'package:oats_package/data/services/biometrics_service.dart';
import 'package:oats_package/data/services/dialog_service.dart';
import 'package:oats_package/data/services/firebase_service.dart';
import 'package:oats_package/data/services/permission_service.dart';
import 'package:oats_package/data/services/push_notifications_service.dart';
import 'package:oats_package/data/services/settings_service.dart';
import 'package:oats_package/helpers/content_locator.dart';
import 'package:oats_package/helpers/device_details_helper.dart';
import 'package:oats_package/helpers/navigation_helper.dart';
import 'package:oats_package/oats_package.dart';
import 'package:oats_package/views/base/sub_viewmodel.dart';
import 'package:oats_theme/oats_theme.dart';
import 'package:oats_theme/providers/theme_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SettingsViewModel extends SubViewModel {
  final BiometricsService _biometricsService = getService<BiometricsService>();
  final DialogService _dialogService = getService<DialogService>();
  final PermissionService _permissionService = getService<PermissionService>();
  final PushNotificationsService _pushNotificationsService = getService<PushNotificationsService>();
  final FirebaseService _firebaseService = getService<FirebaseService>();
  late final SettingsService _settingsService = getServiceAndListen<SettingsService>(_onSettingsServiceDidChange);

  final RealmSettingsViewContent? screenCopy = ContentLocator.settingsView.content;
  final RealmBiometricsPromptsContent? biometricsCopy = ContentLocator.biometrics.content;
  final RealmPopupsContent? popupsCopy = ContentLocator.popups.content;

  late RealmSettingsData settings;

  final BuildContext context;
  final themeProvider = Provider.of<ThemeProvider>(globalNavigatorKey.currentContext!, listen: false);

  bool biometricsSupported = false;
  bool systemAppearanceSupported = false;
  bool showPushNotificationSetting = false;

  SettingsViewModel(this.context) {
    settings = _settingsService.loadSettingsData();
    checkSupportedSettings();
  }

  @override
  AuditPageDetail get auditPageDetail =>
      AuditPageDetail(name: screenCopy?.analyticsName, feature: AuditEventFeature.settings);

  void updateSetting(SettingsType settingType, bool value) async {
    switch (settingType) {
      case SettingsType.location:
        if (!await _permissionService.checkHasPermissions([Permission.location])) {
          var response = await _permissionService.requestLocationPermissions();

          if (response == PermissionResult.granted) {
            _settingsService.setRealmSettingByType(SettingsType.location, true);
          } else if (response == PermissionResult.deniedShowDialogForSettings) {
            _dialogService.showGenericDialog(
              title: popupsCopy?.locationPermissionDeniedPopup?.headingText,
              description: popupsCopy?.locationPermissionDeniedPopup?.descriptionText,
              primaryButtonText: popupsCopy?.locationPermissionDeniedPopup?.primaryActionButton?.text,
              primaryOnTap: () async {
                NavigationHelper.pop();
                await _permissionService.goToAppSettings();
              },
              secondaryButtonText: popupsCopy?.locationPermissionDeniedPopup?.secondaryActionButton?.text,
            );
          }
        } else {
          await _permissionService.goToAppSettings();
        }
      case SettingsType.biometrics:
        if (value) {
          var result = await _biometricsService.authenticateUser(
            title: biometricsCopy?.enableBiometrics?.headingText,
            message: biometricsCopy?.enableBiometrics?.descriptionText ?? '',
            cancelText: biometricsCopy?.enableBiometrics?.cancelText,
          );
          if (result == AuthenticationStatus.success) {
            _settingsService.setRealmSettingByType(settingType, value);
          }
        } else {
          _settingsService.setRealmSettingByType(settingType, value);
        }
      case SettingsType.notifications:
        void openNotificationPermissionDialog() => _dialogService.showGenericDialog(
          title: popupsCopy?.notificationPermissionDeniedPopup?.headingText,
          description: popupsCopy?.notificationPermissionDeniedPopup?.descriptionText,
          primaryButtonText: popupsCopy?.notificationPermissionDeniedPopup?.primaryActionButton?.text,
          primaryOnTap: () async {
            NavigationHelper.pop();
            await _permissionService.goToAppSettings();
          },
          secondaryButtonText: popupsCopy?.notificationPermissionDeniedPopup?.secondaryActionButton?.text,
        );

        if (value) {
          if (Platform.isIOS || await DeviceDetailsHelper.isGMSAvailable()) {
            var authorizationStatus = await _firebaseService.getPushNotificationPermissionAuthorizationStatus();

            switch (authorizationStatus) {
              case AuthorizationStatus.authorized:
                break;
              case AuthorizationStatus.notDetermined:
              case AuthorizationStatus.provisional:
              case AuthorizationStatus.denied:
                authorizationStatus = await _firebaseService.requestPushNotificationPermissions();
                if (authorizationStatus != AuthorizationStatus.authorized) {
                  openNotificationPermissionDialog();
                }
            }

            await _settingsService.updateSettingsFromSystem();
          }
        } else {
          await _permissionService.goToAppSettings();
        }
      case SettingsType.darkMode:
        themeProvider.brightness = value ? Brightness.dark : Brightness.light;
        _settingsService.setRealmSettingByType(settingType, value);
      case SettingsType.systemAppearance:
        _settingsService.setRealmSettingByType(settingType, value);
        if (value) {
          var currentBrightness = MediaQuery.platformBrightnessOf(context);
          themeProvider.brightness = currentBrightness;
        } else {
          themeProvider.brightness = Brightness.light;
        }
      default:
        break;
    }

    if (!settings.isManaged) {
      settings = _settingsService.loadSettingsData();
    }

    notifyListeners();
  }

  void checkSupportedSettings() async {
    var biometricSupportStatus = await _biometricsService.checkBiometricSupportStatus();
    biometricsSupported = biometricSupportStatus == BiometricSupportStatus.enrolled;

    if (Platform.isAndroid) {
      systemAppearanceSupported = (await DeviceDetailsHelper.platformVersion() >= 23) ? true : false;
    } else if (Platform.isIOS) {
      systemAppearanceSupported = (await DeviceDetailsHelper.platformVersion() >= 13) ? true : false;
    } else {
      systemAppearanceSupported = false;
    }

    showPushNotificationSetting =
        await _pushNotificationsService.pushNotificationsFeatureEnabled &&
        !(await DeviceDetailsHelper.isHMSAvailable());

    notifyListeners();
  }

  void _onSettingsServiceDidChange() {
    notifyListeners();
  }
}
