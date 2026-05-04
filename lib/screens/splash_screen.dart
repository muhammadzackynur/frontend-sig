import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _scaleIn = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );
    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const WelcomeScreen(),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: _DotNetworkPainter(),
              child: const SizedBox(height: 180),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: ScaleTransition(
                scale: _scaleIn,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.35),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(child: _LocationPinIcon()),
                    ),
                    const SizedBox(height: 24),
                    const Text('FindUs', style: AppTextStyles.splashTitle),
                    const SizedBox(height: 8),
                    const Text(
                      'Stay close, wherever you are',
                      style: AppTextStyles.splashSubtitle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationPinIcon extends StatelessWidget {
  const _LocationPinIcon();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: CustomPaint(painter: _PinIconPainter()),
    );
  }
}

class _PinIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.38;

    canvas.drawCircle(Offset(cx, cy), r + 4, strokePaint);

    final path = Path();
    path.addOval(Rect.fromCircle(center: Offset(cx, cy - 2), radius: r));
    path.moveTo(cx - 5, cy + r - 4);
    path.lineTo(cx, cy + r + 8);
    path.lineTo(cx + 5, cy + r - 4);
    path.close();
    canvas.drawPath(path, paint);

    canvas.drawCircle(
      Offset(cx, cy - 2),
      r * 0.38,
      Paint()..color = AppColors.primary,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _DotNetworkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..color = AppColors.avatarLight.withOpacity(0.5);
    final linePaint = Paint()
      ..color = AppColors.avatarLight.withOpacity(0.3)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final nodes = [
      Offset(size.width * 0.08, size.height * 0.75),
      Offset(size.width * 0.18, size.height * 0.45),
      Offset(size.width * 0.35, size.height * 0.85),
      Offset(size.width * 0.50, size.height * 1.00),
      Offset(size.width * 0.62, size.height * 0.60),
      Offset(size.width * 0.75, size.height * 0.38),
      Offset(size.width * 0.85, size.height * 0.55),
      Offset(size.width * 0.92, size.height * 0.30),
    ];

    for (int i = 0; i < nodes.length - 1; i++) {
      _drawDashed(canvas, nodes[i], nodes[i + 1], linePaint);
    }

    final sizes = [6.0, 10.0, 14.0, 8.0, 12.0, 7.0, 9.0, 6.0];
    for (int i = 0; i < nodes.length; i++) {
      canvas.drawCircle(nodes[i], sizes[i % sizes.length], dotPaint);
    }
  }

  void _drawDashed(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;
    final dist = (p2 - p1).distance;
    const dashLen = 6.0, gapLen = 4.0;
    double drawn = 0;
    while (drawn < dist) {
      final s = drawn / dist;
      final e = ((drawn + dashLen) / dist).clamp(0.0, 1.0);
      canvas.drawLine(
        Offset(p1.dx + dx * s, p1.dy + dy * s),
        Offset(p1.dx + dx * e, p1.dy + dy * e),
        paint,
      );
      drawn += dashLen + gapLen;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
