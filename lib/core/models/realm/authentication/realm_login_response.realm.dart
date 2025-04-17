// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_login_response.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmLoginResponse extends $RealmLoginResponse
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmLoginResponse({
    String? token,
    RealmUser? user,
  }) {
    RealmObjectBase.set(this, 'token', token);
    RealmObjectBase.set(this, 'user', user);
  }

  RealmLoginResponse._();

  @override
  String? get token => RealmObjectBase.get<String>(this, 'token') as String?;
  @override
  set token(String? value) => RealmObjectBase.set(this, 'token', value);

  @override
  RealmUser? get user =>
      RealmObjectBase.get<RealmUser>(this, 'user') as RealmUser?;
  @override
  set user(covariant RealmUser? value) =>
      RealmObjectBase.set(this, 'user', value);

  @override
  Stream<RealmObjectChanges<RealmLoginResponse>> get changes =>
      RealmObjectBase.getChanges<RealmLoginResponse>(this);

  @override
  Stream<RealmObjectChanges<RealmLoginResponse>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmLoginResponse>(this, keyPaths);

  @override
  RealmLoginResponse freeze() =>
      RealmObjectBase.freezeObject<RealmLoginResponse>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'token': token.toEJson(),
      'user': user.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmLoginResponse value) => value.toEJson();
  static RealmLoginResponse _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return RealmLoginResponse(
      token: fromEJson(ejson['token']),
      user: fromEJson(ejson['user']),
    );
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmLoginResponse._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RealmLoginResponse, 'RealmLoginResponse', [
      SchemaProperty('token', RealmPropertyType.string, optional: true),
      SchemaProperty('user', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmUser'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
