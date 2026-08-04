import 'package:flutter/material.dart';

import '../components/app_avatar.dart';
import '../components/gradient_background.dart';
import '../components/glass_card.dart';
import '../components/skill_chip.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required this.onUserClick});

  final ValueChanged<String> onUserClick;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _query = '';
  String _category = 'Barchasi';

  @override
  Widget build(BuildContext context) {
    final users = mockUsers.where((user) {
      final matchesQuery = _query.isEmpty ||
          user.name.toLowerCase().contains(_query.toLowerCase()) ||
          user.skillsOffering.join(' ').toLowerCase().contains(_query.toLowerCase());
      final matchesCategory = _category == 'Barchasi' || user.skillsOffering.any((s) => s.toLowerCase().contains(_category.toLowerCase()));
      return matchesQuery && matchesCategory;
    }).toList();

    return GradientBackground(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Qidirish', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  const Text('Butun dunyodan mentor va skill-partner toping', style: TextStyle(color: AppColors.mutedText)),
                  const SizedBox(height: 18),
                  TextField(
                    onChanged: (v) => setState(() => _query = v),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                      suffixIcon: Icon(Icons.tune_rounded),
                      hintText: 'Ko‘nikma, ism yoki kategoriya...',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 58,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 8),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final selected = _category == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _category = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.muted,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: selected ? AppColors.primary : AppColors.border),
                      ),
                      child: Text(cat, style: TextStyle(color: selected ? Colors.white : AppColors.mutedText, fontWeight: FontWeight.w800)),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: categories.length,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 6, 18, 18),
            sliver: SliverList.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return GlassCard(
                  margin: const EdgeInsets.only(bottom: 12),
                  onTap: () => widget.onUserClick(user.id),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppAvatar(initials: user.avatar, index: index, verified: user.isVerified, size: 52),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(user.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                                ),
                                Text(user.countryFlag),
                                const SizedBox(width: 5),
                                const Icon(Icons.star_rounded, color: AppColors.amber, size: 15),
                                Text(user.rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text('${user.country} • ${user.sessionsCompleted} sessiya', style: const TextStyle(color: AppColors.mutedText, fontSize: 12)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                for (final skill in user.skillsOffering.take(3)) SkillChip(label: skill, color: AppColors.primary, filled: true),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(999),
                                    child: LinearProgressIndicator(
                                      value: (user.matchScore ?? user.trustScore) / 100,
                                      minHeight: 7,
                                      backgroundColor: Colors.white.withOpacity(.10),
                                      valueColor: AlwaysStoppedAnimation(index.isEven ? AppColors.primary : AppColors.green),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text('${user.matchScore ?? user.trustScore}% mos', style: const TextStyle(color: AppColors.green, fontWeight: FontWeight.w900, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
