import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:mzala/core/constants/constants.dart';
import 'package:mzala/core/utils/validators.dart';
import 'package:mzala/viewmodels/auth/register_viewmodel.dart';
import 'package:mzala/views/auth/components/already_have_accout.dart';
import 'package:mzala/views/auth/components/sign_up_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);

    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("First Name"),
            const SizedBox(height: 8),
            TextFormField(
              controller: viewModel.firstNameController,
              validator: Validators.requiredWithFieldName('First Name').call,
              textInputAction: TextInputAction.next,
              enabled: !viewModel.busy,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Last Name"),
            const SizedBox(height: 8),
            TextFormField(
              controller: viewModel.lastNameController,
              validator: Validators.requiredWithFieldName('Last Name').call,
              textInputAction: TextInputAction.next,
              enabled: !viewModel.busy,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Email"),
            const SizedBox(height: 8),
            TextFormField(
              controller: viewModel.emailController,
              validator: Validators.requiredWithFieldName('Email').call,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              enabled: !viewModel.busy,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Phone Number"),
            const SizedBox(height: 8),
            TextFormField(
              controller: viewModel.contactNumberController,
              textInputAction: TextInputAction.next,
              validator: Validators.requiredWithFieldName('Number').call,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              enabled: !viewModel.busy,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Password"),
            const SizedBox(height: 8),
            TextFormField(
              controller: viewModel.passwordController,
              validator: Validators.password.call,
              textInputAction: TextInputAction.next,
              obscureText: !viewModel.isPasswordShown,
              enabled: !viewModel.busy,
              decoration: InputDecoration(
                suffixIcon: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: viewModel.togglePasswordVisibility,
                    icon: SvgPicture.asset(
                      AppIcons.eye,
                      width: 24,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDefaults.padding),
            SignUpButton(
              isLoading: viewModel.busy,
              onPressed: () => viewModel.handleRegister(context),
            ),
            const AlreadyHaveAnAccount(),
            const SizedBox(height: AppDefaults.padding),
          ],
        ),
      ),
    );
  }
}
