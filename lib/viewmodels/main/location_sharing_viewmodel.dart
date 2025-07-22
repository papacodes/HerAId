import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../base_viewmodel.dart';
import '../../services/interfaces/i_permissions_service.dart';
import '../../services/interfaces/i_location_settings_service.dart';
import '../../core/models/realm/settings/location_settings.dart';
import '../../core/initializer.dart';

class LocationSharingViewModel extends BaseViewModel {
  final IPermissionsService _permissionsService = getService<IPermissionsService>();
  final ILocationSettingsService _locationSettingsService = getService<ILocationSettingsService>();

  // Settings state
  bool _deviceLocationEnabled = false;
  bool _shareWithEmergencyContacts = false;
  bool _allowLocationTracking = false;
  LocationPermission _permissionStatus = LocationPermission.denied;
  bool _locationServiceEnabled = false;

  // Getters
  bool get deviceLocationEnabled => _deviceLocationEnabled;
  bool get shareWithEmergencyContacts => _shareWithEmergencyContacts;
  bool get allowLocationTracking => _allowLocationTracking;
  LocationPermission get permissionStatus => _permissionStatus;
  bool get locationServiceEnabled => _locationServiceEnabled;
  bool get hasLocationPermission =>
      _permissionStatus == LocationPermission.always || _permissionStatus == LocationPermission.whileInUse;

  @override
  Future<void> initialise() async {
    setBusy(true);
    await _loadSettings();
    await _checkDeviceLocationStatus();
    setBusy(false);
  }

  Future<void> _loadSettings() async {
    try {
      final settings = await _locationSettingsService.getLocationSettings();
      if (settings != null) {
        _shareWithEmergencyContacts = settings.shareLocationWithEmergencyContacts ?? false;
        _allowLocationTracking = settings.allowLocationTracking ?? false;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading location settings: $e');
    }
  }

  Future<void> _checkDeviceLocationStatus() async {
    try {
      _locationServiceEnabled = await _permissionsService.isLocationServiceEnabled();
      _permissionStatus = await _permissionsService.checkLocationPermission();
      _deviceLocationEnabled = _locationServiceEnabled && hasLocationPermission;
      notifyListeners();
    } catch (e) {
      print('Error checking device location status: $e');
    }
  }

  Future<void> toggleDeviceLocation(bool value) async {
    if (value) {
      // Request permission if trying to enable
      if (!_locationServiceEnabled) {
        // Show dialog to enable location services
        await _showLocationServiceDialog();
        return;
      }

      if (!hasLocationPermission) {
        final permission = await _permissionsService.requestLocationPermission();
        _permissionStatus = permission;

        if (!hasLocationPermission) {
          // Permission denied, show settings dialog
          await _showPermissionDialog();
          return;
        }
      }
    }

    await _locationSettingsService.updateLocationServicesEnabled(value);
    await _checkDeviceLocationStatus();
  }

  Future<void> toggleShareWithEmergencyContacts(bool value) async {
    _shareWithEmergencyContacts = value;
    await _locationSettingsService.updateShareLocationWithEmergencyContacts(value);
    notifyListeners();
  }

  Future<void> toggleAllowLocationTracking(bool value) async {
    _allowLocationTracking = value;
    await _locationSettingsService.updateAllowLocationTracking(value);
    notifyListeners();
  }

  Future<void> openAppSettings() async {
    await _permissionsService.openAppSettings();
    // Refresh status when user returns
    await Future.delayed(const Duration(seconds: 1));
    await _checkDeviceLocationStatus();
  }

  Future<void> _showLocationServiceDialog() async {
    // This would show a dialog explaining location services need to be enabled
    print('Location services need to be enabled in device settings');
  }

  Future<void> _showPermissionDialog() async {
    // This would show a dialog explaining permission is needed
    print('Location permission is required');
  }

  Future<void> refreshLocationStatus() async {
    setBusy(true);
    await _checkDeviceLocationStatus();
    setBusy(false);
  }
}
