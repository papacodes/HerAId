import 'package:her_aid/res/dimens.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/imagefile.png',
          height: 190,
        ),
        AppDimens.gap(2),
      ],
    );
  }
}
