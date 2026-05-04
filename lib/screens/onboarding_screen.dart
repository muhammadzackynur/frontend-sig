import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login.dart'; // Import file login.dart agar bisa dikenali

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _animController;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _scale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _onPageChanged(int i) {
    setState(() => _currentPage = i);
    _animController.reset();
    _animController.forward();
  }

  void _handleNext() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigasi ke LoginScreen menggunakan pushReplacement agar
      // user tidak bisa kembali ke onboarding dengan tombol 'back'
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  _Slide1(scale: _scale, fade: _fade),
                  _Slide2(scale: _scale, fade: _fade),
                  _Slide3(scale: _scale, fade: _fade),
                ],
              ),
            ),
            _DotIndicator(count: 3, current: _currentPage),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  _PrimaryBtn(
                    text: _currentPage == 2 ? 'Get Started' : ' Get Started',
                    onTap: _handleNext,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke LoginScreen saat teks ini ditekan
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'I already have an account',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SLIDE SHELLS
// ═══════════════════════════════════════════════════════════════
class _Slide1 extends StatelessWidget {
  final Animation<double> scale, fade;
  const _Slide1({required this.scale, required this.fade});
  @override
  Widget build(BuildContext context) => _SlideShell(
    scale: scale,
    fade: fade,
    illustration: const _MapIllustration(),
    title: 'Know where they are',
    subtitle: 'See your family and friends on a\nprivate map in real-time.',
  );
}

class _Slide2 extends StatelessWidget {
  final Animation<double> scale, fade;
  const _Slide2({required this.scale, required this.fade});
  @override
  Widget build(BuildContext context) => _SlideShell(
    scale: scale,
    fade: fade,
    illustration: const _CircleIllustration(),
    title: 'Create your Circle',
    subtitle:
        'Organize your people into private\nCircles for family, friends, or work.',
  );
}

class _Slide3 extends StatelessWidget {
  final Animation<double> scale, fade;
  const _Slide3({required this.scale, required this.fade});
  @override
  Widget build(BuildContext context) => _SlideShell(
    scale: scale,
    fade: fade,
    illustration: const _HistoryIllustration(),
    title: 'Review any moment',
    subtitle:
        'Look back at where everyone has been\nwith detailed location history.',
    isPremium: true,
  );
}

class _SlideShell extends StatelessWidget {
  final Animation<double> scale, fade;
  final Widget illustration;
  final String title, subtitle;
  final bool isPremium;

  const _SlideShell({
    required this.scale,
    required this.fade,
    required this.illustration,
    required this.title,
    required this.subtitle,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          const Spacer(flex: 1),
          FadeTransition(
            opacity: fade,
            child: ScaleTransition(scale: scale, child: illustration),
          ),
          const Spacer(flex: 1),
          Text(
            title,
            style: AppTextStyles.headingLarge,
            textAlign: TextAlign.center,
          ),
          if (isPremium) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFD4C4B0).withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.king_bed_outlined,
                    size: 14,
                    color: Color(0xFF5D4037),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Premium',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 14),
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// ILLUSTRATIONS
// ═══════════════════════════════════════════════════════════════

// Ilustrasi Peta (Slide 1) menggunakan Custom Painter & Stack
class _MapIllustration extends StatelessWidget {
  const _MapIllustration();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
          const Icon(Icons.map_outlined, size: 180, color: AppColors.divider),
        ],
      ),
    );
  }
}

// Ilustrasi Circle (Slide 2)
class _CircleIllustration extends StatelessWidget {
  const _CircleIllustration();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.group_work_outlined,
        size: 200,
        color: AppColors.primary,
      ),
    );
  }
}

// Ilustrasi History/Review (Slide 3)
class _HistoryIllustration extends StatelessWidget {
  const _HistoryIllustration();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.history_toggle_off_rounded,
        size: 200,
        color: AppColors.avatarBrown,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ═══════════════════════════════════════════════════════════════
class _DotIndicator extends StatelessWidget {
  final int count, current;
  const _DotIndicator({required this.count, required this.current});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: i == current ? 22 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: i == current ? AppColors.primary : AppColors.dotInactive,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class _PrimaryBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _PrimaryBtn({required this.text, required this.onTap});
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
              color: AppColors.primary.withOpacity(0.30),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
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
