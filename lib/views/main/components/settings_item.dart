import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData? leadingIcon;
  final bool showArrow;

  const SettingsItem({
    super.key,
    required this.title,
    required this.onTap,
    this.leadingIcon,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            if (leadingIcon != null) Icon(leadingIcon, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            if (showArrow)
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
