import 'package:flutter/material.dart';
import 'package:her_aid/models/http_service/http_error.dart';
import 'package:her_aid/models/requests/register_request.dart';
import 'package:her_aid/models/responses/login_response.dart';
import 'package:her_aid/res/navigator.dart';
import 'package:her_aid/res/toast.dart';
import 'package:her_aid/services/http_service/http_service.dart';
import 'package:her_aid/services/implementation/authentication_service.dart';
import 'package:her_aid/viewmodels/base_viewmodel.dart';
import 'package:her_aid/views/screens/authentication/login_view.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthenticationService authenticationService = AuthenticationService(HttpService());
  final formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  TextEditingController emergencyContactController = TextEditingController();
  TextEditingController universityController = TextEditingController();

  bool _register = false;
  bool get register => _register;

  String _error = "Registration failed. Please check your input.";
  String get error => _error;

  Future<LoginResponse?> registerUser(RegisterRequest registerReqest) async {
    try {
      setBusy(true);
      var response = await authenticationService.register(registerReqest);
      _register = false;

      return response;
    } on HttpError catch (err) {
      _error = err.message;
      return null;
    } catch (e) {
      _error = 'An unexpected error occurred. Please try again later.';
      return null;
    } finally {
      _register = false;
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
      LoginResponse? response = await registerUser(
        RegisterRequest(
          email: emailController.text,
          name: firstNameController.text,
          surname: lastNameController.text,
          password: passwordController.text,
          contactNumber: contactNumberController.text,
        ),
      );

      if (response != null) {
        ToastManager.showSuccessToast(context, "Registration success");
        NavigatorHelper.replaceAll(const LoginView());
        return;
      }
      ToastManager.showErrorToast(context, error);
    }
  }
}
