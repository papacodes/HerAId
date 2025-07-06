import 'package:json_annotation/json_annotation.dart';

part 'app_details.g.dart';

@JsonSerializable()
class AppDetails {
  String? deviceUniqueId;
  String? deviceName;
  String? devicePhoneManufacturer;
  String? devicePhoneModel;
  String? deviceOS;
  String? deviceOSVersion;
  int? builderNumber;
  String? versionNumber;

  AppDetails({
    this.deviceUniqueId,
    this.deviceName,
    this.devicePhoneManufacturer,
    this.devicePhoneModel,
    this.deviceOS,
    this.deviceOSVersion,
    this.builderNumber,
    this.versionNumber,
  });

  factory AppDetails.fromJson(Map<String, dynamic> json) => _$AppDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AppDetailsToJson(this);
}
