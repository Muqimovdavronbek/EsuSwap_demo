import 'package:flutter/material.dart';

import '../models/skill_models.dart';
import '../theme/app_theme.dart';

class ExchangeBadge extends StatelessWidget {
  const ExchangeBadge({super.key, required this.type});

  final ExchangeType type;

  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    late final String label;
    late final Color color;
    switch (type) {
      case ExchangeType.time:
        icon = Icons.schedule_rounded;
        label = 'Vaqt';
        color = AppColors.primary;
        break;
      case ExchangeType.points:
        icon = Icons.bolt_rounded;
        label = 'Ball';
        color = AppColors.purple;
        break;
      case ExchangeType.cash:
        icon = Icons.attach_money_rounded;
        label = 'Pullik';
        color = AppColors.green;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(.28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
