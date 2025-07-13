import 'package:get_it/get_it.dart';
import 'package:mzala/services/realm/realm_service.dart';
import 'package:mzala/services/interfaces/i_permissions_service.dart';
import 'package:mzala/services/implementation/permissions_service.dart';

final getService = GetIt.instance;
bool hasActiveSession = false;

class Initializer {
  Initializer() {
    _registerServices();
    _checkForActiveSession();
  }

  static void _registerServices() {
    GetIt.instance.registerLazySingleton<RealmService>(() => RealmService());
    GetIt.instance.registerLazySingleton<IPermissionsService>(() => PermissionsService());
  }

  static void _checkForActiveSession() {
    final realmService = getService<RealmService>();
    final userData = realmService.getCurrentUserData();
    //TODO:: WE HAVE TO HAVE A CHECK HERE THATS GOING TO DETERMINE IF THE SESSION IS STILL VALID
    if (userData != null && userData.token != null) {
      hasActiveSession = true;
    }
  }
}
