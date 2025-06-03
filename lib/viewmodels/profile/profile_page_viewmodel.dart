import 'package:mzala/core/initializer.dart';
import 'package:mzala/core/models/realm/authentication/realm_login_response.dart';
import 'package:mzala/services/realm/realm_service.dart';
import 'package:mzala/viewmodels/base_viewmodel.dart';

class ProfilePageViewModel extends BaseViewModel {
  final realmService = getService<RealmService>();
  late RealmLoginResponse? userData;

  ProfilePageViewModel() {
    getUserData();
  }

  void getUserData() {
    userData = realmService.getCurrentUserData();
  }
}
