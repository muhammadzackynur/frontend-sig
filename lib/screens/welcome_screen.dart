import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const OnboardingScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const _VennDiagramWidget(),
                  const Spacer(flex: 1),
                  const Text(
                    'Connect with your\ninner circles.',
                    style: AppTextStyles.headingLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'A private space for the people who matter most. Share moments, plan events, and stay close.',
                    style: AppTextStyles.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 2),
                  _PrimaryBtn(label: 'Get Started', onTap: _onGetStarted),
                  const SizedBox(height: 14),
                  _OutlineBtn(label: 'Sign In', onTap: () {}),
                  const SizedBox(height: 24),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                      children: [
                        TextSpan(text: 'By continuing, you agree to our '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ' & '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VennDiagramWidget extends StatelessWidget {
  const _VennDiagramWidget();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 220,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.avatarLight.withOpacity(0.18),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: _VennCircle(
              color: AppColors.avatarLight.withOpacity(0.22),
              border: AppColors.avatarBrown.withOpacity(0.5),
            ),
          ),
          Positioned(
            right: 20,
            top: 40,
            child: _VennCircle(
              color: AppColors.avatarLight.withOpacity(0.22),
              border: AppColors.avatarLight.withOpacity(0.7),
            ),
          ),
          Positioned(
            top: 20,
            child: _VennCircle(
              color: AppColors.avatarLight.withOpacity(0.22),
              border: AppColors.textMuted.withOpacity(0.45),
            ),
          ),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.link_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

class _VennCircle extends StatelessWidget {
  final Color color, border;
  const _VennCircle({required this.color, required this.border});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: border, width: 1.5),
      ),
    );
  }
}

class _PrimaryBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryBtn({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineBtn({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
