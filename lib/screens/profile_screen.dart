import 'package:flutter/material.dart';

import '../components/app_avatar.dart';
import '../components/gradient_background.dart';
import '../components/glass_card.dart';
import '../components/gradient_button.dart';
import '../components/section_header.dart';
import '../components/skill_chip.dart';
import '../components/stat_tile.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
        children: [
          Row(
            children: [
              const Expanded(child: Text('Profil', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900))),
              IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.settings_rounded)),
            ],
          ),
          const SizedBox(height: 12),
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppTheme.heroGradient),
                  child: const AppAvatar(initials: 'DM', index: 1, verified: true, size: 94),
                ),
                const SizedBox(height: 14),
                const Text('Muqimov Davronbek', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                const Text('Mobile Developer • O‘zbekiston 🇺🇿', style: TextStyle(color: AppColors.mutedText)),
                const SizedBox(height: 14),
                const Text(
                  'Flutter, UI/UX va startup mahsulotlar yaratishni o‘rganaman. EduSwap orqali bilim almashish va jamoa bilan o‘sishni xohlayman.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mutedText, height: 1.48),
                ),
                const SizedBox(height: 18),
                const Row(
                  children: [
                    StatTile(value: '1240', label: 'Ball', icon: Icons.bolt_rounded, color: AppColors.primary),
                    SizedBox(width: 10),
                    StatTile(value: '12', label: 'Level', icon: Icons.military_tech_rounded, color: AppColors.amber),
                    SizedBox(width: 10),
                    StatTile(value: '94%', label: 'Trust', icon: Icons.verified_rounded, color: AppColors.green),
                  ],
                ),
              ],
            ),
          ),
          const SectionHeader(title: 'Men o‘rgata olaman', icon: Icons.school_rounded),
          GlassCard(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                SkillChip(label: 'Flutter', filled: true),
                SkillChip(label: 'Dart', filled: true),
                SkillChip(label: 'Firebase', filled: true),
                SkillChip(label: 'UI slicing', filled: true),
              ],
            ),
          ),
          const SectionHeader(title: 'O‘rganmoqchiman', icon: Icons.auto_awesome_rounded),
          GlassCard(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                SkillChip(label: 'AI integration', color: AppColors.green, filled: true),
                SkillChip(label: 'Backend', color: AppColors.green, filled: true),
                SkillChip(label: 'English speaking', color: AppColors.green, filled: true),
              ],
            ),
          ),
          const SectionHeader(title: 'O‘zlashtirish statistikasi', icon: Icons.query_stats_rounded),
          GlassCard(
            child: Column(
              children: const [
                _ProgressRow(title: 'Dart amaliyoti', value: .76, percent: '76%'),
                SizedBox(height: 14),
                _ProgressRow(title: 'UI komponentlar', value: .84, percent: '84%'),
                SizedBox(height: 14),
                _ProgressRow(title: 'Mentor sessiyalari', value: .58, percent: '58%'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          GradientButton(label: 'Profilni tahrirlash', icon: Icons.edit_rounded, onPressed: () {}),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({required this.title, required this.value, required this.percent});
  final String title;
  final double value;
  final String percent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800))),
            Text(percent, style: const TextStyle(color: AppColors.green, fontWeight: FontWeight.w900)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
