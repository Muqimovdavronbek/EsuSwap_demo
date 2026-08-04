import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({
    super.key,
    required this.label,
    this.color = AppColors.primary,
    this.filled = false,
  });

  final String label;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: filled ? color.withOpacity(.16) : AppColors.muted,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(.25)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: filled ? color : AppColors.text,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
