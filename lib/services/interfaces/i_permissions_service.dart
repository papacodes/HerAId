import 'package:geolocator/geolocator.dart';

abstract class IPermissionsService {
  /// Check if location services are enabled on the device
  Future<bool> isLocationServiceEnabled();
  
  /// Check current location permission status
  Future<LocationPermission> checkLocationPermission();
  
  /// Request location permission from user
  Future<LocationPermission> requestLocationPermission();
  
  /// Check if location permission is granted
  Future<bool> hasLocationPermission();
  
  /// Open app settings if permission is permanently denied
  Future<bool> openAppSettings();
  
  /// Get location permission status with user-friendly message
  Future<PermissionStatus> getLocationPermissionStatus();
}

enum PermissionStatus {
  granted,
  denied,
  deniedForever,
  serviceDisabled,
}