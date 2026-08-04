import 'package:flutter/material.dart';

import '../models/skill_models.dart';
import '../theme/app_theme.dart';
import 'app_avatar.dart';
import 'exchange_badge.dart';
import 'glass_card.dart';
import 'skill_chip.dart';

class SkillCardTile extends StatelessWidget {
  const SkillCardTile({
    super.key,
    required this.card,
    required this.index,
    this.onTap,
  });

  final SkillCard card;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 14),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(initials: card.user.avatar, index: index, verified: card.user.isVerified),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            card.user.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(card.user.countryFlag),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${card.user.sessionsCompleted} sessiya • ${card.user.trustScore}% trust',
                      style: const TextStyle(color: AppColors.mutedText, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.amber, size: 16),
                      Text(
                        card.user.rating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ExchangeBadge(type: card.exchangeType),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            card.skillTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, height: 1.15),
          ),
          const SizedBox(height: 8),
          Text(
            card.description,
            style: const TextStyle(color: AppColors.mutedText, fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SkillChip(label: card.category, filled: true),
              for (final tag in card.tags)
                SkillChip(
                  label: tag == 'Give' ? 'O‘rgatadi' : 'O‘rganadi',
                  color: tag == 'Give' ? AppColors.primary : AppColors.green,
                  filled: true,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
