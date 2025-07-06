// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppDetails _$AppDetailsFromJson(Map<String, dynamic> json) => AppDetails(
      deviceUniqueId: json['deviceUniqueId'] as String?,
      deviceName: json['deviceName'] as String?,
      devicePhoneManufacturer: json['devicePhoneManufacturer'] as String?,
      devicePhoneModel: json['devicePhoneModel'] as String?,
      deviceOS: json['deviceOS'] as String?,
      deviceOSVersion: json['deviceOSVersion'] as String?,
      builderNumber: (json['builderNumber'] as num?)?.toInt(),
      versionNumber: json['versionNumber'] as String?,
    );

Map<String, dynamic> _$AppDetailsToJson(AppDetails instance) =>
    <String, dynamic>{
      'deviceUniqueId': instance.deviceUniqueId,
      'deviceName': instance.deviceName,
      'devicePhoneManufacturer': instance.devicePhoneManufacturer,
      'devicePhoneModel': instance.devicePhoneModel,
      'deviceOS': instance.deviceOS,
      'deviceOSVersion': instance.deviceOSVersion,
      'builderNumber': instance.builderNumber,
      'versionNumber': instance.versionNumber,
    };
