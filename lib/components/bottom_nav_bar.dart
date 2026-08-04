import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum NavTab { home, explore, match, messages, profile }

class EduBottomNavBar extends StatelessWidget {
  const EduBottomNavBar({
    super.key,
    required this.activeTab,
    required this.onChanged,
    this.messageCount = 1,
  });

  final NavTab activeTab;
  final ValueChanged<NavTab> onChanged;
  final int messageCount;

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(NavTab.home, 'Bosh', Icons.home_rounded),
      _NavItem(NavTab.explore, 'Qidirish', Icons.search_rounded),
      _NavItem(NavTab.match, 'Moslik', Icons.bolt_rounded),
      _NavItem(NavTab.messages, 'Xabarlar', Icons.chat_bubble_rounded),
      _NavItem(NavTab.profile, 'Profil', Icons.person_rounded),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceStrong.withOpacity(.96),
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.25), blurRadius: 18, offset: const Offset(0, -8)),
        ],
      ),
      child: Row(
        children: [
          for (final item in items)
            Expanded(
              child: _BottomItem(
                item: item,
                selected: activeTab == item.tab,
                messageCount: item.tab == NavTab.messages ? messageCount : 0,
                onTap: () => onChanged(item.tab),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.tab, this.label, this.icon);
  final NavTab tab;
  final String label;
  final IconData icon;
}

class _BottomItem extends StatelessWidget {
  const _BottomItem({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.messageCount,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;
  final int messageCount;

  @override
  Widget build(BuildContext context) {
    final isMatch = item.tab == NavTab.match;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: isMatch ? 50 : 38,
            height: isMatch ? 50 : 38,
            decoration: BoxDecoration(
              gradient: isMatch && selected ? AppTheme.heroGradient : null,
              color: isMatch
                  ? AppColors.primary.withOpacity(selected ? 1 : .13)
                  : selected
                      ? AppColors.primary.withOpacity(.16)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(isMatch ? 999 : 14),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Icon(item.icon, color: selected || isMatch ? Colors.white : AppColors.mutedText, size: isMatch ? 24 : 22),
                if (messageCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 17,
                      height: 17,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
                      child: Text('$messageCount', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: TextStyle(
              color: selected ? AppColors.text : AppColors.mutedText,
              fontWeight: selected ? FontWeight.w900 : FontWeight.w600,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}
