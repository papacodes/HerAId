import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String joinDate;
  final String? avatarUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.joinDate,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
          child: avatarUrl == null
              ? const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                )
              : null,
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          joinDate,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}