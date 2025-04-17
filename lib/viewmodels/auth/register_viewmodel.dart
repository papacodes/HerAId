import 'package:flutter/material.dart';
import 'package:mzala/core/models/http_service/http_error.dart';
import 'package:mzala/core/models/realm/authentication/realm_login_response.dart';
import 'package:mzala/core/models/requests/register_request.dart';
import 'package:mzala/core/models/responses/login_response.dart';
import 'package:mzala/res/navigator.dart';
import 'package:mzala/res/toast.dart';
import 'package:mzala/services/http_service/http_service.dart';
import 'package:mzala/services/implementation/authentication_service.dart';
import 'package:mzala/viewmodels/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthenticationService authenticationService = AuthenticationService(HttpService());
  final formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  TextEditingController passwordContactController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isPasswordShown = false;

  String _error = "Registration failed. Please check your input.";
  String get error => _error;

  Future<$RealmLoginResponse?> registerUser(RegisterRequest registerReqest) async {
    try {
      setBusy(true);
      var response = await authenticationService.register(registerReqest);

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

  passwordConfirmation(String password, String passwordConfirmation) {
    if (password != passwordConfirmation) {
      passwordController;
    }
  }

  handleRegister(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var response = await registerUser(
        RegisterRequest(
          email: emailController.text,
          name: firstNameController.text,
          surname: lastNameController.text,
          password: passwordController.text,
          confirmPassword: passwordController.text,
          contactNumber: contactNumberController.text,
        ),
      );

      if (response != null) {
        ToastManager.showSuccessToast(context, "Registration success");
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
