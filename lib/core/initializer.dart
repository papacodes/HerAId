import 'package:get_it/get_it.dart';
import 'package:mzala/services/realm/realm_service.dart';

final getService = GetIt.instance;

class Initializer {
  Initializer() {
    _registerServices();
  }

  static void _registerServices() {
    GetIt.instance.registerLazySingleton<RealmService>(() => RealmService());
  }
}
