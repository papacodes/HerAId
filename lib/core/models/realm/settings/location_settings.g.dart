// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

$LocationSettings _$$LocationSettingsFromJson(Map<String, dynamic> json) =>
    $LocationSettings()
      ..id = json['id'] as String
      ..locationServicesEnabled = json['locationServicesEnabled'] as bool?
      ..shareLocationWithEmergencyContacts =
          json['shareLocationWithEmergencyContacts'] as bool?
      ..allowLocationTracking = json['allowLocationTracking'] as bool?
      ..lastUpdated = json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String)
      ..createdAt = json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String);
