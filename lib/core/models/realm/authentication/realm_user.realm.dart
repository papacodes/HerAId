// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmUser extends $RealmUser
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmUser(
    int? id, {
    String? name,
    String? surname,
    String? email,
    String? contactNumber,
    String? address,
    String? picture,
    String? status,
    DateTime? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'surname', surname);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'contactNumber', contactNumber);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'picture', picture);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'emailVerifiedAt', emailVerifiedAt);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  RealmUser._();

  @override
  int? get id => RealmObjectBase.get<int>(this, 'id') as int?;
  @override
  set id(int? value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get surname =>
      RealmObjectBase.get<String>(this, 'surname') as String?;
  @override
  set surname(String? value) => RealmObjectBase.set(this, 'surname', value);

  @override
  String? get email => RealmObjectBase.get<String>(this, 'email') as String?;
  @override
  set email(String? value) => RealmObjectBase.set(this, 'email', value);

  @override
  String? get contactNumber =>
      RealmObjectBase.get<String>(this, 'contactNumber') as String?;
  @override
  set contactNumber(String? value) =>
      RealmObjectBase.set(this, 'contactNumber', value);

  @override
  String? get address =>
      RealmObjectBase.get<String>(this, 'address') as String?;
  @override
  set address(String? value) => RealmObjectBase.set(this, 'address', value);

  @override
  String? get picture =>
      RealmObjectBase.get<String>(this, 'picture') as String?;
  @override
  set picture(String? value) => RealmObjectBase.set(this, 'picture', value);

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

  @override
  DateTime? get emailVerifiedAt =>
      RealmObjectBase.get<DateTime>(this, 'emailVerifiedAt') as DateTime?;
  @override
  set emailVerifiedAt(DateTime? value) =>
      RealmObjectBase.set(this, 'emailVerifiedAt', value);

  @override
  DateTime? get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime?;
  @override
  set createdAt(DateTime? value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  DateTime? get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime?;
  @override
  set updatedAt(DateTime? value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  Stream<RealmObjectChanges<RealmUser>> get changes =>
      RealmObjectBase.getChanges<RealmUser>(this);

  @override
  Stream<RealmObjectChanges<RealmUser>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmUser>(this, keyPaths);

  @override
  RealmUser freeze() => RealmObjectBase.freezeObject<RealmUser>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'surname': surname.toEJson(),
      'email': email.toEJson(),
      'contactNumber': contactNumber.toEJson(),
      'address': address.toEJson(),
      'picture': picture.toEJson(),
      'status': status.toEJson(),
      'emailVerifiedAt': emailVerifiedAt.toEJson(),
      'createdAt': createdAt.toEJson(),
      'updatedAt': updatedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmUser value) => value.toEJson();
  static RealmUser _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
      } =>
        RealmUser(
          fromEJson(ejson['id']),
          name: fromEJson(ejson['name']),
          surname: fromEJson(ejson['surname']),
          email: fromEJson(ejson['email']),
          contactNumber: fromEJson(ejson['contactNumber']),
          address: fromEJson(ejson['address']),
          picture: fromEJson(ejson['picture']),
          status: fromEJson(ejson['status']),
          emailVerifiedAt: fromEJson(ejson['emailVerifiedAt']),
          createdAt: fromEJson(ejson['createdAt']),
          updatedAt: fromEJson(ejson['updatedAt']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmUser._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, RealmUser, 'RealmUser', [
      SchemaProperty('id', RealmPropertyType.int,
          optional: true, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('surname', RealmPropertyType.string, optional: true),
      SchemaProperty('email', RealmPropertyType.string, optional: true),
      SchemaProperty('contactNumber', RealmPropertyType.string, optional: true),
      SchemaProperty('address', RealmPropertyType.string, optional: true),
      SchemaProperty('picture', RealmPropertyType.string, optional: true),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
      SchemaProperty('emailVerifiedAt', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
