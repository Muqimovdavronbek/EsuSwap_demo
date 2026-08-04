import 'package:flutter/material.dart';

import '../components/app_avatar.dart';
import '../components/gradient_background.dart';
import '../components/glass_card.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  bool _global = true;

  @override
  Widget build(BuildContext context) {
    final ranked = List.of(mockUsers)..sort((a, b) => (a.rank ?? 99).compareTo(b.rank ?? 99));
    return GradientBackground(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 18, 0),
            child: Row(
              children: [
                IconButton(onPressed: widget.onBack, icon: const Icon(Icons.chevron_left_rounded)),
                const Icon(Icons.emoji_events_rounded, color: AppColors.amber),
                const SizedBox(width: 8),
                const Expanded(child: Text('Leaderboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: AppColors.muted, borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.border)),
              child: Row(
                children: [
                  _ScopeTab(label: 'Global', selected: _global, onTap: () => setState(() => _global = true)),
                  _ScopeTab(label: 'O‘zbekiston', selected: !_global, onTap: () => setState(() => _global = false)),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
              children: [
                _Podium(users: ranked.take(3).toList()),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    Icon(Icons.trending_up_rounded, color: AppColors.primary, size: 17),
                    SizedBox(width: 8),
                    Text('Haftalik faol reyting', style: TextStyle(color: AppColors.mutedText, fontWeight: FontWeight.w900)),
                  ],
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < ranked.length; i++) _RankTile(user: ranked[i], index: i),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScopeTab extends StatelessWidget {
  const _ScopeTab({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 11),
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: selected ? AppTheme.primaryGradient : null, borderRadius: BorderRadius.circular(999)),
          child: Text(label, style: TextStyle(color: selected ? Colors.white : AppColors.mutedText, fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}

class _Podium extends StatelessWidget {
  const _Podium({required this.users});
  final List<dynamic> users;

  @override
  Widget build(BuildContext context) {
    final ordered = [if (users.length > 1) users[1], if (users.isNotEmpty) users[0], if (users.length > 2) users[2]];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < ordered.length; i++)
          Expanded(
            child: _PodiumUser(
              user: ordered[i],
              visualIndex: i,
              height: i == 1 ? 112 : 82,
              avatarSize: i == 1 ? 70 : 56,
            ),
          ),
      ],
    );
  }
}

class _PodiumUser extends StatelessWidget {
  const _PodiumUser({required this.user, required this.visualIndex, required this.height, required this.avatarSize});
  final dynamic user;
  final int visualIndex;
  final double height;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    final rank = user.rank ?? 0;
    final medalColor = rank == 1 ? AppColors.amber : rank == 2 ? AppColors.mutedText : AppColors.green;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: medalColor, shape: BoxShape.circle),
          child: Text('$rank', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        ),
        const SizedBox(height: 8),
        AppAvatar(initials: user.avatar, index: visualIndex, verified: user.isVerified, size: avatarSize),
        const SizedBox(height: 8),
        Text(user.name.split(' ').first, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
        const SizedBox(height: 4),
        Text('${user.weeklyPoints} pt', style: TextStyle(color: medalColor, fontWeight: FontWeight.w900, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [medalColor.withOpacity(.34), medalColor.withOpacity(.10)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            border: Border.all(color: medalColor.withOpacity(.25)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text('#$rank', style: TextStyle(color: medalColor, fontWeight: FontWeight.w900)),
          ),
        ),
      ],
    );
  }
}

class _RankTile extends StatelessWidget {
  const _RankTile({required this.user, required this.index});
  final dynamic user;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(width: 26, child: Text('#${user.rank}', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.mutedText, fontWeight: FontWeight.w900))),
          const SizedBox(width: 10),
          AppAvatar(initials: user.avatar, index: index, verified: user.isVerified, size: 44),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 3),
                Text('${user.countryFlag} ${user.country} • ${user.rating}', style: const TextStyle(color: AppColors.mutedText, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${user.weeklyPoints}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              const Text('ball', style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
