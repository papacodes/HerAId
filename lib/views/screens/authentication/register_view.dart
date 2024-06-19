import 'package:flutter/material.dart';
import 'package:her_aid/res/dimens.dart';
import 'package:her_aid/viewmodels/authentication/register_viewmodel.dart';
import 'package:her_aid/viewmodels/view_model_provider.dart';
import 'package:her_aid/views/widgets/button.dart';
import 'package:her_aid/views/widgets/textfield.dart';
import 'package:iconsax/iconsax.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late RegisterViewModel vm;

  @override
  void dispose() {
    vm.firstNameController.dispose();
    vm.lastNameController.dispose();
    vm.emailController.dispose();
    vm.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ViewModelProvider<RegisterViewModel>(
        viewModelBuilder: () => RegisterViewModel(),
        builder: (context, vm, child) {
          this.vm = vm;
          return _body(context);
        },
      );

  Scaffold _body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: vm.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const AppLogo(),
                  Row(
                    children: [
                      Flexible(
                        child: TextInputField(
                          controller: vm.firstNameController,
                          icon: Iconsax.user,
                          hintText: "First Name",
                        ),
                      ),
                      AppDimens.gap(1),
                      Flexible(
                        child: TextInputField(
                          controller: vm.lastNameController,
                          icon: Iconsax.user_add,
                          hintText: "Last Name",
                        ),
                      )
                    ],
                  ),
                  TextInputField(
                    controller: vm.emailController,
                    icon: Iconsax.message,
                    inputType: TextFieldType.email,
                    hintText: "E-mail address",
                  ),
                  TextInputField(
                    controller: vm.contactNumberController,
                    icon: Iconsax.call,
                    inputType: TextFieldType.number,
                    hintText: "Contact Number",
                  ),
                  TextInputField(
                    controller: vm.passwordController,
                    icon: Iconsax.key,
                    inputType: TextFieldType.password,
                    hintText: "Password",
                  ),
                  AppDimens.gap(1),
                  PrimaryButton(
                    isLoading: vm.busy,
                    onTap: () => vm.handleRegister(context),
                    text: "Create account",
                    outlined: false,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
