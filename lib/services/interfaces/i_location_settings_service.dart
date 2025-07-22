import '../../../core/models/realm/settings/location_settings.dart';

abstract class ILocationSettingsService {
  /// Get current location settings
  Future<LocationSettings?> getLocationSettings();
  
  /// Save location settings
  Future<void> saveLocationSettings(LocationSettings settings);
  
  /// Update specific setting
  Future<void> updateLocationServicesEnabled(bool enabled);
  Future<void> updateShareLocationWithEmergencyContacts(bool enabled);
  Future<void> updateAllowLocationTracking(bool enabled);
  
  /// Get default settings
  LocationSettings getDefaultSettings();
  
  /// Check if settings exist
  Future<bool> hasLocationSettings();
}