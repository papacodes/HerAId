import 'package:flutter/material.dart';
import 'package:mzala/core/models/http_service/http_error.dart';
import 'package:mzala/core/models/realm/authentication/realm_login_response.dart';
import 'package:mzala/core/models/requests/login_request.dart';
import 'package:mzala/res/toast.dart';
import 'package:mzala/services/http_service/http_service.dart';
import 'package:mzala/services/implementation/authentication_service.dart';
import 'package:mzala/services/realm/realm_service.dart';
import 'package:mzala/viewmodels/base_viewmodel.dart';
import 'package:mzala/core/initializer.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService authenticationService = AuthenticationService(HttpService());
  final formKey = GlobalKey<FormState>();
  late final RealmService _realmService = getService<RealmService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _error = "Login failed. Please check your credentials.";
  String get error => _error;

  bool isPasswordShown = false;

  Future<$RealmLoginResponse?> loginWith(LoginReqest loginReqest) async {
    try {
      setBusy(true);
      final response = await authenticationService.login(loginReqest);

      return response;
    } on HttpError catch (err) {
      _error = err.message;
      return null;
    } catch (e) {
      _error = 'An unexpected error occurred. Please try again later.';
      return null;
    } finally {
      setBusy(false);
    }
  }

  handleLogin(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      setBusy(true);

      var response = await loginWith(LoginReqest(email: emailController.text, password: passwordController.text));

      if (response?.token != null) {
        await _realmService.saveUserData(response!);
        ToastManager.showSuccessToast(context, "Login success");
        return;
      }
      ToastManager.showErrorToast(context, error);
    }
  }

  togglePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    notifyListeners();
  }
}
