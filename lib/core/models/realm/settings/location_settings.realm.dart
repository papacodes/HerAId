// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_settings.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class LocationSettings extends $LocationSettings
    with RealmEntity, RealmObjectBase, RealmObject {
  LocationSettings(
    String id, {
    bool? locationServicesEnabled,
    bool? shareLocationWithEmergencyContacts,
    bool? allowLocationTracking,
    DateTime? lastUpdated,
    DateTime? createdAt,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(
        this, 'locationServicesEnabled', locationServicesEnabled);
    RealmObjectBase.set(this, 'shareLocationWithEmergencyContacts',
        shareLocationWithEmergencyContacts);
    RealmObjectBase.set(this, 'allowLocationTracking', allowLocationTracking);
    RealmObjectBase.set(this, 'lastUpdated', lastUpdated);
    RealmObjectBase.set(this, 'createdAt', createdAt);
  }

  LocationSettings._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  bool? get locationServicesEnabled =>
      RealmObjectBase.get<bool>(this, 'locationServicesEnabled') as bool?;
  @override
  set locationServicesEnabled(bool? value) =>
      RealmObjectBase.set(this, 'locationServicesEnabled', value);

  @override
  bool? get shareLocationWithEmergencyContacts =>
      RealmObjectBase.get<bool>(this, 'shareLocationWithEmergencyContacts')
          as bool?;
  @override
  set shareLocationWithEmergencyContacts(bool? value) =>
      RealmObjectBase.set(this, 'shareLocationWithEmergencyContacts', value);

  @override
  bool? get allowLocationTracking =>
      RealmObjectBase.get<bool>(this, 'allowLocationTracking') as bool?;
  @override
  set allowLocationTracking(bool? value) =>
      RealmObjectBase.set(this, 'allowLocationTracking', value);

  @override
  DateTime? get lastUpdated =>
      RealmObjectBase.get<DateTime>(this, 'lastUpdated') as DateTime?;
  @override
  set lastUpdated(DateTime? value) =>
      RealmObjectBase.set(this, 'lastUpdated', value);

  @override
  DateTime? get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime?;
  @override
  set createdAt(DateTime? value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  Stream<RealmObjectChanges<LocationSettings>> get changes =>
      RealmObjectBase.getChanges<LocationSettings>(this);

  @override
  Stream<RealmObjectChanges<LocationSettings>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<LocationSettings>(this, keyPaths);

  @override
  LocationSettings freeze() =>
      RealmObjectBase.freezeObject<LocationSettings>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'locationServicesEnabled': locationServicesEnabled.toEJson(),
      'shareLocationWithEmergencyContacts':
          shareLocationWithEmergencyContacts.toEJson(),
      'allowLocationTracking': allowLocationTracking.toEJson(),
      'lastUpdated': lastUpdated.toEJson(),
      'createdAt': createdAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(LocationSettings value) => value.toEJson();
  static LocationSettings _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
      } =>
        LocationSettings(
          fromEJson(id),
          locationServicesEnabled: fromEJson(ejson['locationServicesEnabled']),
          shareLocationWithEmergencyContacts:
              fromEJson(ejson['shareLocationWithEmergencyContacts']),
          allowLocationTracking: fromEJson(ejson['allowLocationTracking']),
          lastUpdated: fromEJson(ejson['lastUpdated']),
          createdAt: fromEJson(ejson['createdAt']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(LocationSettings._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, LocationSettings, 'LocationSettings', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('locationServicesEnabled', RealmPropertyType.bool,
          optional: true),
      SchemaProperty(
          'shareLocationWithEmergencyContacts', RealmPropertyType.bool,
          optional: true),
      SchemaProperty('allowLocationTracking', RealmPropertyType.bool,
          optional: true),
      SchemaProperty('lastUpdated', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
