import 'package:flutter/material.dart';

import '../components/app_avatar.dart';
import '../components/gradient_background.dart';
import '../components/glass_card.dart';
import '../data/mock_data.dart';
import '../models/skill_models.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<AppNotification> _items = List.of(mockNotifications);

  @override
  Widget build(BuildContext context) {
    final unread = _items.where((n) => !n.read).length;
    return GradientBackground(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 18, 12),
            child: Row(
              children: [
                IconButton(onPressed: widget.onBack, icon: const Icon(Icons.chevron_left_rounded)),
                Expanded(
                  child: Row(
                    children: [
                      const Text('Bildirishnomalar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      if (unread > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
                          child: Text('$unread', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                        ),
                      ],
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () => setState(() => _items = []),
                  icon: const Icon(Icons.done_all_rounded, size: 18),
                  label: const Text('Tozalash'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _items.isEmpty
                ? const _EmptyNotifications()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      final sectionTitle = index == 0 ? 'Yangi' : index == 2 ? 'Oldingi' : null;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (sectionTitle != null)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 10, 0, 8),
                              child: Text(sectionTitle.toUpperCase(), style: const TextStyle(color: AppColors.mutedText, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.3)),
                            ),
                          _NotificationTile(
                            notification: item,
                            index: index,
                            onDelete: () => setState(() => _items.removeAt(index)),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.index, required this.onDelete});

  final AppNotification notification;
  final int index;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      color: notification.read ? AppColors.surface.withOpacity(.78) : AppColors.surfaceStrong.withOpacity(.96),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          notification.avatar != null ? AppAvatar(initials: notification.avatar!, index: index, size: 42) : _IconBox(type: notification.type),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.w900))),
                    if (!notification.read)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(notification.message, style: const TextStyle(color: AppColors.mutedText, height: 1.38, fontSize: 12.5)),
                const SizedBox(height: 7),
                Text(notification.time, style: TextStyle(color: AppColors.mutedText.withOpacity(.75), fontSize: 11)),
              ],
            ),
          ),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline_rounded, color: AppColors.red, size: 20)),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({required this.type});
  final AppNotificationType type;

  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    late final Color color;
    switch (type) {
      case AppNotificationType.match:
        icon = Icons.bolt_rounded;
        color = AppColors.primary;
        break;
      case AppNotificationType.session:
        icon = Icons.video_call_rounded;
        color = AppColors.green;
        break;
      case AppNotificationType.review:
        icon = Icons.star_rounded;
        color = AppColors.amber;
        break;
      case AppNotificationType.system:
        icon = Icons.notifications_rounded;
        color = AppColors.purple;
        break;
    }
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(color: color.withOpacity(.14), borderRadius: BorderRadius.circular(15), border: Border.all(color: color.withOpacity(.25))),
      child: Icon(icon, color: color),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(color: AppColors.muted, borderRadius: BorderRadius.circular(26), border: Border.all(color: AppColors.border)),
            child: const Icon(Icons.notifications_off_rounded, color: AppColors.mutedText, size: 36),
          ),
          const SizedBox(height: 16),
          const Text('Hozircha bildirishnoma yo‘q', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
          const SizedBox(height: 6),
          const Text('Yangi mosliklar shu yerda ko‘rinadi', style: TextStyle(color: AppColors.mutedText)),
        ],
      ),
    );
  }
}
