import 'package:flutter/material.dart';
import 'package:her_aid/core/components/asset_image.dart';
import 'package:her_aid/core/constants/general_constants.dart';
import 'package:her_aid/core/constants/constants.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: const AspectRatio(
            aspectRatio: 1 / 1,
            child: AssetImageWithLoader(AppImages.tempLogo),
          ),
        ),
        Text(
          'Welcome to our',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          GeneralConstants.appName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        )
      ],
    );
  }
}
