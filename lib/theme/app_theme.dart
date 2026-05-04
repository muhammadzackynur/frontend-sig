import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF5E6D3);
  static const Color primary = Color(0xFF4A4035);
  static const Color primaryDark = Color(0xFF3A3028);
  static const Color textDark = Color(0xFF2C2416);
  static const Color textMuted = Color(0xFF8A7968);
  static const Color cardBg = Color(0xFFEDD9C0);
  static const Color avatarBrown = Color(0xFF6B5B45);
  static const Color avatarLight = Color(0xFFB8A88A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFD4C4B0);
  static const Color dotInactive = Color(0xFFB8A88A);
}

class AppTextStyles {
  static const TextStyle splashTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );

  static const TextStyle splashSubtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static const TextStyle headingLarge = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    height: 1.5,
  );
}
