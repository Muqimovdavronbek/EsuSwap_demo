import 'package:flutter/material.dart';

import '../components/app_avatar.dart';
import '../components/gradient_background.dart';
import '../components/glass_card.dart';
import '../components/gradient_button.dart';
import '../components/skill_chip.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key, required this.onMatch});

  final ValueChanged<String> onMatch;

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  int _index = 0;
  bool _matched = false;

  void _next() {
    setState(() {
      _matched = false;
      _index = (_index + 1) % mockUsers.length;
    });
  }

  void _match() {
    final user = mockUsers[_index];
    setState(() => _matched = true);
    widget.onMatch(user.id);
  }

  @override
  Widget build(BuildContext context) {
    final user = mockUsers[_index];
    return GradientBackground(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('AI Moslik', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            const Text('Ko‘nikma almashish uchun eng yaqin mos insonlar', style: TextStyle(color: AppColors.mutedText)),
            const SizedBox(height: 22),
            Expanded(
              child: Center(
                child: AnimatedScale(
                  scale: _matched ? 1.03 : 1,
                  duration: const Duration(milliseconds: 260),
                  child: GlassCard(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 116,
                          height: 116,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            gradient: AppTheme.heroGradient,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(.38), blurRadius: 38, offset: const Offset(0, 18))],
                          ),
                          child: AppAvatar(initials: user.avatar, size: 106, index: _index, verified: user.isVerified),
                        ),
                        const SizedBox(height: 18),
                        Text(user.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 4),
                        Text('${user.countryFlag} ${user.country}', style: const TextStyle(color: AppColors.mutedText)),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.green.withOpacity(.14),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: AppColors.green.withOpacity(.30)),
                          ),
                          child: Text('${user.matchScore ?? user.trustScore}% moslik', style: const TextStyle(color: AppColors.green, fontWeight: FontWeight.w900, fontSize: 18)),
                        ),
                        const SizedBox(height: 20),
                        Text(user.bio, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.mutedText, height: 1.5)),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('O‘rgatadi', style: TextStyle(color: AppColors.primary.withOpacity(.95), fontWeight: FontWeight.w900)),
                        ),
                        const SizedBox(height: 8),
                        Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
                          for (final s in user.skillsOffering) SkillChip(label: s, color: AppColors.primary, filled: true),
                        ]),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('O‘rganmoqchi', style: TextStyle(color: AppColors.green.withOpacity(.95), fontWeight: FontWeight.w900)),
                        ),
                        const SizedBox(height: 8),
                        Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
                          for (final s in user.skillsWanting) SkillChip(label: s, color: AppColors.green, filled: true),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_matched)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(.14),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.green.withOpacity(.32)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_rounded, color: AppColors.green),
                    SizedBox(width: 8),
                    Text('Moslik topildi! Xabarlarga o‘tilmoqda...', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _next,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    ),
                    icon: const Icon(Icons.close_rounded),
                    label: const Text('Keyingisi', style: TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: GradientButton(label: 'Mos keladi', icon: Icons.bolt_rounded, onPressed: _match, height: 52)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
