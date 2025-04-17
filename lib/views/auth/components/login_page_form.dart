import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mzala/core/routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'package:mzala/core/constants/constants.dart';
import 'package:mzala/core/themes/app_themes.dart';
import 'package:mzala/core/utils/validators.dart';
import 'package:mzala/views/auth/components/login_button.dart';
import 'package:mzala/viewmodels/auth/login_viewmodel.dart';

class LoginPageForm extends StatelessWidget {
  const LoginPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Field
              const Text("Email Address"),
              const SizedBox(height: 8),
              TextFormField(
                controller: viewModel.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email.call,
                textInputAction: TextInputAction.next,
                enabled: !viewModel.busy,
              ),
              const SizedBox(height: AppDefaults.padding),

              // Password Field
              const Text("Password"),
              const SizedBox(height: 8),
              TextFormField(
                validator: Validators.password.call,
                controller: viewModel.passwordController,
                onFieldSubmitted: (_) => viewModel.handleLogin(context),
                textInputAction: TextInputAction.done,
                obscureText: !viewModel.isPasswordShown,
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

              // Forget Password labelLarge
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: const Text('Forget Password?'),
                ),
              ),

              // Login labelLarge
              LoginButton(
                isLoading: viewModel.busy,
                onPressed: () => viewModel.handleLogin(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
