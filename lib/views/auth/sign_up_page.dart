import 'package:flutter/material.dart';
import 'package:mzala/viewmodels/view_model_provider.dart';
import 'package:provider/provider.dart';
import 'package:mzala/core/constants/app_colors.dart';
import 'package:mzala/core/constants/app_defaults.dart';
import 'package:mzala/viewmodels/auth/register_viewmodel.dart';
import 'package:mzala/views/auth/components/sign_up_form.dart';
import 'package:mzala/views/auth/components/sign_up_page_header.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) => ViewModelProvider<RegisterViewModel>(
        viewModelBuilder: () => RegisterViewModel(),
        builder: (context, vm, child) {
          return _body(context, vm);
        },
      );

  _body(BuildContext context, RegisterViewModel vm) => const Scaffold(
        backgroundColor: AppColors.scaffoldWithBoxBackground,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SignUpPageHeader(),
                  SizedBox(height: AppDefaults.padding),
                  SignUpForm(),
                ],
              ),
            ),
          ),
        ),
      );
}
