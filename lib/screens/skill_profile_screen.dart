import 'package:flutter/material.dart';

import '../components/app_avatar.dart';
import '../components/gradient_background.dart';
import '../components/glass_card.dart';
import '../components/gradient_button.dart';
import '../components/section_header.dart';
import '../components/skill_chip.dart';
import '../components/stat_tile.dart';
import '../models/skill_models.dart';
import '../theme/app_theme.dart';

class SkillProfileScreen extends StatelessWidget {
  const SkillProfileScreen({super.key, required this.user, required this.onBack, required this.onMessage});

  final SkillUser user;
  final VoidCallback onBack;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 18, 0),
            child: Row(
              children: [
                IconButton(onPressed: onBack, icon: const Icon(Icons.chevron_left_rounded)),
                const Expanded(child: Text('Skill Profil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
                IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.ios_share_rounded)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 96),
              children: [
                GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      AppAvatar(initials: user.avatar, index: user.rank ?? 0, verified: user.isVerified, size: 94),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900), textAlign: TextAlign.center)),
                          const SizedBox(width: 6),
                          Text(user.countryFlag),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(user.country, style: const TextStyle(color: AppColors.mutedText)),
                      const SizedBox(height: 12),
                      Text(user.bio, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.mutedText, height: 1.48)),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          StatTile(value: '${user.sessionsCompleted}', label: 'Sessiya', icon: Icons.video_call_rounded, color: AppColors.primary),
                          const SizedBox(width: 10),
                          StatTile(value: '${user.trustScore}%', label: 'Trust', icon: Icons.verified_rounded, color: AppColors.green),
                          const SizedBox(width: 10),
                          StatTile(value: user.rating.toStringAsFixed(1), label: 'Rating', icon: Icons.star_rounded, color: AppColors.amber),
                        ],
                      ),
                    ],
                  ),
                ),
                const SectionHeader(title: 'Haqida', icon: Icons.menu_book_rounded),
                GlassCard(
                  child: const Text(
                    'EduSwap sessiyalarida vaqt, ball yoki pullik model orqali almashish mumkin. Har bir suhbatdan keyin ishonch reytingi yangilanadi.',
                    style: TextStyle(color: AppColors.mutedText, height: 1.48),
                  ),
                ),
                const SectionHeader(title: 'O‘rgatadi', icon: Icons.school_rounded),
                GlassCard(
                  child: Wrap(spacing: 8, runSpacing: 8, children: [for (final s in user.skillsOffering) SkillChip(label: s, filled: true)]),
                ),
                const SectionHeader(title: 'O‘rganmoqchi', icon: Icons.auto_awesome_rounded),
                GlassCard(
                  child: Wrap(spacing: 8, runSpacing: 8, children: [for (final s in user.skillsWanting) SkillChip(label: s, color: AppColors.green, filled: true)]),
                ),
                const SectionHeader(title: 'Sharhlar', icon: Icons.reviews_rounded),
                GlassCard(
                  child: Column(
                    children: const [
                      _ReviewTile(name: 'Sardor', text: 'Sessiya juda foydali bo‘ldi. Amaliy misollar bilan tushuntirdi.'),
                      Divider(color: AppColors.border),
                      _ReviewTile(name: 'Madina', text: 'Vaqtida keldi, aniq reja berdi va resurslar ulashdi.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
            decoration: const BoxDecoration(color: AppColors.surfaceStrong, border: Border(top: BorderSide(color: AppColors.border))),
            child: GradientButton(label: 'Xabar yozish', icon: Icons.chat_bubble_rounded, onPressed: onMessage),
          ),
        ],
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.name, required this.text});
  final String name;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppAvatar(initials: 'ST', size: 34, index: 3),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(width: 6), const Icon(Icons.star_rounded, color: AppColors.amber, size: 14), const Text('5.0', style: TextStyle(fontSize: 12))]),
                const SizedBox(height: 3),
                Text(text, style: const TextStyle(color: AppColors.mutedText, height: 1.4, fontSize: 12.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
