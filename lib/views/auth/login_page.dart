import 'package:flutter/material.dart';
import 'package:mzala/core/constants/constants.dart';
import 'package:mzala/viewmodels/auth/login_viewmodel.dart';
import 'package:mzala/viewmodels/view_model_provider.dart';
import 'components/dont_have_account_row.dart';
import 'components/login_header.dart';
import 'components/login_page_form.dart';
import 'components/social_logins.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => ViewModelProvider<LoginViewModel>(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, vm, child) {
          return _body(context, vm);
        },
      );

  Widget _body(BuildContext context, LoginViewModel vm) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginPageHeader(),
                LoginPageForm(),
                SizedBox(height: AppDefaults.padding),
                SocialLogins(),
                DontHaveAccountRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
