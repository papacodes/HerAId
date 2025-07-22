import 'package:json_annotation/json_annotation.dart';
import 'package:realm/realm.dart';

part 'location_settings.g.dart';
part 'location_settings.realm.dart';

@RealmModel()
@JsonSerializable(createToJson: false)
class $LocationSettings {
  @PrimaryKey()
  late String id; // Use a fixed ID like 'location_settings'

  late bool? locationServicesEnabled;
  late bool? shareLocationWithEmergencyContacts;
  late bool? allowLocationTracking;
  late DateTime? lastUpdated;
  late DateTime? createdAt;

  LocationSettings toRealmObject() => LocationSettings(
        id,
        locationServicesEnabled: locationServicesEnabled,
        shareLocationWithEmergencyContacts: shareLocationWithEmergencyContacts,
        allowLocationTracking: allowLocationTracking,
        lastUpdated: lastUpdated,
        createdAt: createdAt,
      );

  static LocationSettings fromJson(Map<String, dynamic> json) => _$$LocationSettingsFromJson(json).toRealmObject();
}
