import 'package:realm/realm.dart';
import '../interfaces/i_location_settings_service.dart';
import '../../core/models/realm/settings/location_settings.dart';
import '../realm/realm_service.dart';
import '../../core/initializer.dart';

class LocationSettingsService implements ILocationSettingsService {
  final RealmService _realmService = getService<RealmService>();
  static const String _settingsId = 'location_settings';

  @override
  Future<LocationSettings?> getLocationSettings() async {
    try {
      final realm = _realmService.realm;
      return realm.find<LocationSettings>(_settingsId);
    } catch (e) {
      print('Error getting location settings: $e');
      return null;
    }
  }

  @override
  Future<void> saveLocationSettings(LocationSettings settings) async {
    try {
      final realm = _realmService.realm;
      realm.write(() {
        realm.add(settings, update: true);
      });
    } catch (e) {
      print('Error saving location settings: $e');
      throw Exception('Failed to save location settings');
    }
  }

  @override
  Future<void> updateLocationServicesEnabled(bool enabled) async {
    final settings = await getLocationSettings() ?? getDefaultSettings();
    settings.locationServicesEnabled = enabled;
    settings.lastUpdated = DateTime.now();
    await saveLocationSettings(settings);
  }

  @override
  Future<void> updateShareLocationWithEmergencyContacts(bool enabled) async {
    final settings = await getLocationSettings() ?? getDefaultSettings();
    settings.shareLocationWithEmergencyContacts = enabled;
    settings.lastUpdated = DateTime.now();
    await saveLocationSettings(settings);
  }

  @override
  Future<void> updateAllowLocationTracking(bool enabled) async {
    final settings = await getLocationSettings() ?? getDefaultSettings();
    settings.allowLocationTracking = enabled;
    settings.lastUpdated = DateTime.now();
    await saveLocationSettings(settings);
  }

  @override
  LocationSettings getDefaultSettings() {
    final now = DateTime.now();
    return LocationSettings(
      _settingsId,
      locationServicesEnabled: false,
      shareLocationWithEmergencyContacts: false,
      allowLocationTracking: false,
      lastUpdated: now,
      createdAt: now,
    );
  }

  @override
  Future<bool> hasLocationSettings() async {
    final settings = await getLocationSettings();
    return settings != null;
  }
}
