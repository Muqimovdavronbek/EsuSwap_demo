import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.icon,
  });

  final String title;
  final String? action;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.primary, size: 17),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
          if (action != null)
            Text(
              action!,
              style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w800),
            ),
        ],
      ),
    );
  }
}
