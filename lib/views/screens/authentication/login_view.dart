import 'package:flutter/material.dart';
import 'package:her_aid/res/dimens.dart';
import 'package:her_aid/res/navigator.dart';
import 'package:her_aid/viewmodels/authentication/login_viewmodel.dart';
import 'package:her_aid/viewmodels/view_model_provider.dart';
import 'package:her_aid/views/widgets/button.dart';
import 'package:her_aid/views/widgets/textfield.dart';
import 'package:iconsax/iconsax.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel vm;

  @override
  void dispose() {
    vm.emailController.dispose();
    vm.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ViewModelProvider<LoginViewModel>(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, vm, child) {
          this.vm = vm;
          return _body(context);
        },
      );

  Scaffold _body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: vm.formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // const AppLogo(),
                TextInputField(
                  controller: vm.emailController,
                  icon: Iconsax.user,
                  hintText: "E-mail address",
                  inputType: TextFieldType.email,
                ),
                TextInputField(
                  controller: vm.passwordController,
                  icon: Iconsax.key,
                  hintText: "Password",
                  inputType: TextFieldType.password,
                ),
                AppDimens.gap(1),
                PrimaryButton(
                  isLoading: vm.busy,
                  onTap: () => vm.handleLogin(context),
                  text: "Login",
                  outlined: false,
                ),
                PrimaryButton(
                  // onTap: () => NavigatorHelper.to(const RegisterView(), context),
                  text: "Create Account",
                  iconData: Iconsax.user,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
