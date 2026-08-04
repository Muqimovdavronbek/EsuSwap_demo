import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

const avatarGradients = <LinearGradient>[
  LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)]),
  LinearGradient(colors: [Color(0xFF22C55E), Color(0xFF16A34A)]),
  LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFEF4444)]),
  LinearGradient(colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)]),
  LinearGradient(colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)]),
  LinearGradient(colors: [Color(0xFF64748B), Color(0xFF334155)]),
];

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.initials,
    this.size = 46,
    this.index = 0,
    this.verified = false,
  });

  final String initials;
  final double size;
  final int index;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + (verified ? 4 : 0),
      height: size + (verified ? 4 : 0),
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: avatarGradients[index % avatarGradients.length],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(.25),
                  blurRadius: 14,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: size * .32,
              ),
            ),
          ),
          if (verified)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * .32,
                height: size * .32,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 2),
                ),
                child: Icon(Icons.check, color: Colors.white, size: size * .20),
              ),
            ),
        ],
      ),
    );
  }
}
