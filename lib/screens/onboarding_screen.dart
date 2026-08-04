import 'package:flutter/material.dart';

import '../components/gradient_background.dart';
import '../components/gradient_button.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onGetStarted});

  final VoidCallback onGetStarted;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _slide = 0;

  final _slides = const [
    _OnboardingSlide(
      icon: Icons.bolt_rounded,
      title: "Bilimingni baham ko‘r",
      text: "EduSwap — mahsulot emas, mahorat almashiladigan global ijtimoiy platforma.",
      chips: ['Dizayn', 'Kod', 'Musiqa'],
      accent: AppColors.primary,
    ),
    _OnboardingSlide(
      icon: Icons.groups_rounded,
      title: 'Aqlli moslik tizimi',
      text: "AI yordamida sizga mos mentor, hamkor yoki ko‘nikma almashadigan insonni tez toping.",
      chips: ['Global', 'AI-powered', 'Mentor'],
      accent: AppColors.purple,
    ),
    _OnboardingSlide(
      icon: Icons.emoji_events_rounded,
      title: "Ball, badge va reyting",
      text: "Har bir sessiya, sharh va yordam ballga aylanadi. O‘sish statistikangiz doim ko‘rinib turadi.",
      chips: ['Yutuqlar', 'Reyting', 'Progress'],
      accent: AppColors.green,
    ),
  ];

  void _next() {
    if (_slide == _slides.length - 1) {
      widget.onGetStarted();
    } else {
      setState(() => _slide++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_slide];
    return GradientBackground(
      child: Stack(
        children: [
          Positioned(
            top: -70,
            right: -80,
            child: _GlowCircle(color: slide.accent, size: 220),
          ),
          Positioned(
            bottom: 80,
            left: -80,
            child: _GlowCircle(color: AppColors.green, size: 180),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'EDUSWAP',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                      ),
                    ),
                    TextButton(
                      onPressed: widget.onGetStarted,
                      child: const Text('O‘tkazish', style: TextStyle(color: AppColors.mutedText)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 260),
                        child: Container(
                          key: ValueKey(_slide),
                          width: 112,
                          height: 112,
                          decoration: BoxDecoration(
                            gradient: AppTheme.heroGradient,
                            borderRadius: BorderRadius.circular(34),
                            boxShadow: [
                              BoxShadow(
                                color: slide.accent.withOpacity(.38),
                                blurRadius: 34,
                                offset: const Offset(0, 18),
                              ),
                            ],
                          ),
                          child: Icon(slide.icon, color: Colors.white, size: 50),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: slide.chips
                            .map((chip) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: slide.accent.withOpacity(.16),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(color: slide.accent.withOpacity(.30)),
                                  ),
                                  child: Text(chip, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 28),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 260),
                        child: Column(
                          key: ValueKey('text$_slide'),
                          children: [
                            Text(
                              slide.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w900, height: 1.08),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              slide.text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.mutedText, fontSize: 15, height: 1.55),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 22),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _slides.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          width: i == _slide ? 24 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: i == _slide ? slide.accent : AppColors.muted,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GradientButton(
                      label: _slide == _slides.length - 1 ? 'Boshlash' : 'Davom etish',
                      icon: Icons.chevron_right_rounded,
                      onPressed: _next,
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: widget.onGetStarted,
                      child: const Text.rich(
                        TextSpan(
                          text: 'Akkauntingiz bormi? ',
                          style: TextStyle(color: AppColors.mutedText),
                          children: [TextSpan(text: 'Kirish', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900))],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({required this.icon, required this.title, required this.text, required this.chips, required this.accent});
  final IconData icon;
  final String title;
  final String text;
  final List<String> chips;
  final Color accent;
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(.22),
        boxShadow: [BoxShadow(color: color.withOpacity(.26), blurRadius: 90, spreadRadius: 35)],
      ),
    );
  }
}
