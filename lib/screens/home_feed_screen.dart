import 'package:flutter/material.dart';

import '../components/app_avatar.dart';
import '../components/gradient_background.dart';
import '../components/glass_card.dart';
import '../components/section_header.dart';
import '../components/skill_card_tile.dart';
import '../components/stat_tile.dart';
import '../data/mock_data.dart';
import '../models/skill_models.dart';
import '../theme/app_theme.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({
    super.key,
    required this.onCardClick,
    required this.onNotificationsClick,
    required this.onLeaderboardClick,
    required this.notificationCount,
  });

  final ValueChanged<SkillCard> onCardClick;
  final VoidCallback onNotificationsClick;
  final VoidCallback onLeaderboardClick;
  final int notificationCount;

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  String _selectedCategory = 'Barchasi';

  @override
  Widget build(BuildContext context) {
    final filteredCards = _selectedCategory == 'Barchasi'
        ? mockSkillCards
        : mockSkillCards.where((card) => card.category == _selectedCategory).toList();

    return GradientBackground(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Header(onBell: widget.onNotificationsClick, count: widget.notificationCount)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 0),
              child: _HeroProgressCard(onLeaderboardClick: widget.onLeaderboardClick),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final selected = cat == _selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                      decoration: BoxDecoration(
                        gradient: selected ? AppTheme.primaryGradient : null,
                        color: selected ? null : AppColors.muted,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: selected ? Colors.transparent : AppColors.border),
                      ),
                      child: Text(cat, style: TextStyle(fontWeight: FontWeight.w900, color: selected ? Colors.white : AppColors.mutedText)),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: categories.length,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SectionHeader(title: 'Tavsiya qilingan ko‘nikmalar', action: 'Barchasi', icon: Icons.auto_awesome_rounded),
                for (int i = 0; i < filteredCards.length; i++)
                  SkillCardTile(card: filteredCards[i], index: i, onTap: () => widget.onCardClick(filteredCards[i])),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBell, required this.count});
  final VoidCallback onBell;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
      child: Row(
        children: [
          const AppAvatar(initials: 'ME', index: 1, verified: true, size: 44),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Salom, Davronbek 👋', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 19)),
                SizedBox(height: 3),
                Text('Bugun nima o‘rganamiz?', style: TextStyle(color: AppColors.mutedText, fontSize: 12.5)),
              ],
            ),
          ),
          IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          const SizedBox(width: 8),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton.filledTonal(onPressed: onBell, icon: const Icon(Icons.notifications_rounded)),
              if (count > 0)
                Positioned(
                  right: 3,
                  top: 2,
                  child: Container(
                    width: 19,
                    height: 19,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
                    child: Text('$count', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroProgressCard extends StatelessWidget {
  const _HeroProgressCard({required this.onLeaderboardClick});
  final VoidCallback onLeaderboardClick;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [AppColors.primary.withOpacity(.35), AppColors.purple.withOpacity(.20), AppColors.green.withOpacity(.12)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(gradient: AppTheme.heroGradient, borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Level 12 • Skill Trader', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                      SizedBox(height: 4),
                      Text('1240 ball • keyingi badge uchun 260 ball qoldi', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(onPressed: onLeaderboardClick, icon: const Icon(Icons.emoji_events_rounded, color: AppColors.amber)),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: .78,
                minHeight: 9,
                backgroundColor: Colors.white.withOpacity(.12),
                valueColor: const AlwaysStoppedAnimation(AppColors.green),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                StatTile(value: '47', label: 'Sessiya', icon: Icons.video_call_rounded, color: AppColors.primary),
                SizedBox(width: 10),
                StatTile(value: '94%', label: 'Trust', icon: Icons.verified_rounded, color: AppColors.green),
                SizedBox(width: 10),
                StatTile(value: '#12', label: 'Reyting', icon: Icons.trending_up_rounded, color: AppColors.amber),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
