import 'package:geolocator/geolocator.dart';
import 'package:mzala/services/interfaces/i_permissions_service.dart';

class PermissionsService implements IPermissionsService {
  @override
  Future<bool> isLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      print('Error checking location service: $e');
      return false;
    }
  }

  @override
  Future<LocationPermission> checkLocationPermission() async {
    try {
      return await Geolocator.checkPermission();
    } catch (e) {
      print('Error checking location permission: $e');
      return LocationPermission.denied;
    }
  }

  @override
  Future<LocationPermission> requestLocationPermission() async {
    try {
      // First check if location services are enabled
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        return LocationPermission.denied;
      }

      // Check current permission status
      LocationPermission permission = await checkLocationPermission();
      
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
      }
      
      return permission;
    } catch (e) {
      print('Error requesting location permission: $e');
      return LocationPermission.denied;
    }
  }

  @override
  Future<bool> hasLocationPermission() async {
    try {
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) return false;
      
      LocationPermission permission = await checkLocationPermission();
      return permission == LocationPermission.always || 
             permission == LocationPermission.whileInUse;
    } catch (e) {
      print('Error checking if has location permission: $e');
      return false;
    }
  }

  @override
  Future<bool> openAppSettings() async {
    try {
      return await Geolocator.openAppSettings();
    } catch (e) {
      print('Error opening app settings: $e');
      return false;
    }
  }

  @override
  Future<PermissionStatus> getLocationPermissionStatus() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        return PermissionStatus.serviceDisabled;
      }

      // Check permission status
      LocationPermission permission = await checkLocationPermission();
      
      switch (permission) {
        case LocationPermission.always:
        case LocationPermission.whileInUse:
          return PermissionStatus.granted;
        case LocationPermission.denied:
          return PermissionStatus.denied;
        case LocationPermission.deniedForever:
          return PermissionStatus.deniedForever;
        case LocationPermission.unableToDetermine:
          return PermissionStatus.denied;
      }
    } catch (e) {
      print('Error getting location permission status: $e');
      return PermissionStatus.denied;
    }
  }
}