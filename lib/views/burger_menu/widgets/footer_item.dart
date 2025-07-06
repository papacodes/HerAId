import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class FooterItem extends StatelessWidget {
  final String? text;
  final Function() onTap;

  const FooterItem({
    required super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: AppDefaults.padding / 2,
          bottom: AppDefaults.padding / 2,
        ),
        child: Text(
          text ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.placeholder,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
