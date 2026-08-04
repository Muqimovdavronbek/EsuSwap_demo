import 'package:flutter/material.dart';

import '../components/app_avatar.dart';
import '../components/gradient_background.dart';
import '../components/glass_card.dart';
import '../theme/app_theme.dart';

class VideoRoomScreen extends StatelessWidget {
  const VideoRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.chevron_left_rounded)),
                const Expanded(child: Text('Video Sessiya', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
                IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded)),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GlassCard(
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(colors: [AppColors.primary.withOpacity(.28), AppColors.purple.withOpacity(.20), AppColors.background]),
                      ),
                      child: const Center(child: AppAvatar(initials: 'AK', size: 118, index: 0, verified: true)),
                    ),
                    const Positioned(
                      left: 16,
                      bottom: 16,
                      child: Text('Aisha Karimova', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                    ),
                    Positioned(
                      right: 14,
                      top: 14,
                      child: Container(
                        width: 96,
                        height: 132,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceStrong,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Center(child: AppAvatar(initials: 'ME', size: 48, index: 1, verified: true)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _CallButton(icon: Icons.mic_rounded, label: 'Mic', color: AppColors.mutedText, onTap: () {}),
                  _CallButton(icon: Icons.videocam_rounded, label: 'Video', color: AppColors.primary, onTap: () {}),
                  _CallButton(icon: Icons.screen_share_rounded, label: 'Share', color: AppColors.green, onTap: () {}),
                  _CallButton(icon: Icons.call_end_rounded, label: 'End', color: AppColors.red, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallButton extends StatelessWidget {
  const _CallButton({required this.icon, required this.label, required this.color, required this.onTap});

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: color.withOpacity(.16), shape: BoxShape.circle, border: Border.all(color: color.withOpacity(.30))),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: AppColors.mutedText, fontSize: 11, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
