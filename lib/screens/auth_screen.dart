import 'package:flutter/material.dart';

import '../components/glass_card.dart';
import '../components/gradient_background.dart';
import '../components/gradient_button.dart';
import '../theme/app_theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.onBack, required this.onAuth});

  final VoidCallback onBack;
  final VoidCallback onAuth;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -80,
            right: -40,
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withOpacity(.32), AppColors.purple.withOpacity(.16), Colors.transparent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 18, 0),
                child: Row(
                  children: [
                    IconButton.filledTonal(
                      onPressed: widget.onBack,
                      icon: const Icon(Icons.chevron_left_rounded),
                    ),
                    const Expanded(
                      child: Text(
                        'EDUSWAP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.7,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isLogin ? 'Qaytganingizdan xursandmiz' : "Hamjamiyatga qo'shiling",
                        style: const TextStyle(fontSize: 28, height: 1.08, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isLogin
                            ? 'Ko‘nikmalaringizni almashishni davom ettiring'
                            : 'Akkauntingizni yarating va bilim almashishni boshlang',
                        style: const TextStyle(color: AppColors.mutedText, height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.muted,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            _AuthTab(label: 'Kirish', selected: _isLogin, onTap: () => setState(() => _isLogin = true)),
                            _AuthTab(label: "Ro'yxatdan o'tish", selected: !_isLogin, onTap: () => setState(() => _isLogin = false)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(child: _SocialButton(label: 'Google', icon: Icons.g_mobiledata_rounded, onTap: widget.onAuth)),
                          const SizedBox(width: 12),
                          Expanded(child: _SocialButton(label: 'Apple', icon: Icons.apple_rounded, onTap: widget.onAuth)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: const [
                          Expanded(child: Divider(color: AppColors.border)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('yoki email orqali', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                          ),
                          Expanded(child: Divider(color: AppColors.border)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      GlassCard(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          children: [
                            if (!_isLogin) ...[
                              const TextField(
                                decoration: InputDecoration(prefixIcon: Icon(Icons.person_rounded), hintText: 'Ism va familiya'),
                              ),
                              const SizedBox(height: 12),
                            ],
                            const TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(prefixIcon: Icon(Icons.email_rounded), hintText: 'Email manzil'),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              obscureText: !_showPassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_rounded),
                                hintText: 'Parol',
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => _showPassword = !_showPassword),
                                  icon: Icon(_showPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                                ),
                              ),
                            ),
                            if (!_isLogin) ...[
                              const SizedBox(height: 12),
                              const TextField(
                                decoration: InputDecoration(prefixIcon: Icon(Icons.bolt_rounded), hintText: 'Asosiy ko‘nikmangiz'),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (_isLogin)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Parolni unutdingizmi?', style: TextStyle(fontWeight: FontWeight.w800)),
                          ),
                        ),
                      const SizedBox(height: 10),
                      GradientButton(label: _isLogin ? 'Kirish' : 'Akkaunt yaratish', onPressed: widget.onAuth),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Davom etish orqali siz ',
                            style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                            children: [
                              TextSpan(text: 'Foydalanish shartlari', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800)),
                              TextSpan(text: ' va '),
                              TextSpan(text: 'Maxfiylik siyosati', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800)),
                              TextSpan(text: 'ga rozilik bildirasiz.'),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuthTab extends StatelessWidget {
  const _AuthTab({required this.label, required this.selected, required this.onTap});
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: selected ? AppTheme.primaryGradient : null,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(color: selected ? Colors.white : AppColors.mutedText, fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.muted,
      ),
      icon: Icon(icon, size: 22),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}
