import 'package:flutter/material.dart';

import '../components/app_avatar.dart';
import '../components/gradient_background.dart';
import '../components/glass_card.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.userId, required this.onBack});

  final String? userId;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final selected = userId == null ? mockUsers.first : mockUsers.firstWhere((u) => u.id == userId, orElse: () => mockUsers.first);
    return GradientBackground(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 18, 10),
            child: Row(
              children: [
                IconButton(onPressed: onBack, icon: const Icon(Icons.chevron_left_rounded)),
                AppAvatar(initials: selected.avatar, index: mockUsers.indexOf(selected), verified: selected.isVerified, size: 42),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selected.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                      const Text('Online • Video sessiya tayyor', style: TextStyle(color: AppColors.green, fontSize: 12, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.video_call_rounded)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
              itemCount: mockMessages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return const _SessionCard();
                final message = mockMessages[index - 1];
                return _MessageBubble(message: message);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
            decoration: const BoxDecoration(
              color: AppColors.surfaceStrong,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.add_rounded)),
                const SizedBox(width: 8),
                const Expanded(
                  child: TextField(
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(hintText: 'Xabar yozing...', contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(onPressed: () {}, icon: const Icon(Icons.send_rounded)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(gradient: AppTheme.greenGradient, borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.event_available_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Keyingi sessiya', style: TextStyle(fontWeight: FontWeight.w900)),
                SizedBox(height: 4),
                Text('Chorshanba, 19:00 • 1 soat', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.mutedText),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});
  final dynamic message;

  @override
  Widget build(BuildContext context) {
    final isOwn = message.isOwn as bool;
    return Align(
      alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .74),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          gradient: isOwn ? AppTheme.primaryGradient : null,
          color: isOwn ? null : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isOwn ? 18 : 4),
            bottomRight: Radius.circular(isOwn ? 4 : 18),
          ),
          border: isOwn ? null : Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(message.text as String, style: const TextStyle(height: 1.35)),
            const SizedBox(height: 4),
            Text(message.timestamp as String, style: TextStyle(color: isOwn ? Colors.white.withOpacity(.72) : AppColors.mutedText, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
