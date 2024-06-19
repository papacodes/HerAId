import 'package:flutter/material.dart';
import 'package:her_aid/models/http_service/http_error.dart';
import 'package:her_aid/models/requests/login_request.dart';
import 'package:her_aid/models/responses/login_response.dart';
import 'package:her_aid/res/toast.dart';
import 'package:her_aid/services/http_service/http_service.dart';
import 'package:her_aid/services/implementation/authentication_service.dart';
import 'package:her_aid/viewmodels/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService authenticationService = AuthenticationService(HttpService());
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _error = "Login failed. Please check your credentials.";
  String get error => _error;

  Future<LoginResponse?> loginWith(LoginReqest loginReqest) async {
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

      LoginResponse? response =
          await loginWith(LoginReqest(email: emailController.text, password: passwordController.text));

      if (response?.token != null) {
        ToastManager.showSuccessToast(context, "Login success");
        return;
      }
      ToastManager.showErrorToast(context, error);
    }
  }
}
