import 'package:flutter/material.dart';
import 'signup.dart'; // Import file signup.dart

// --- Konstanta Warna Tema ---
class FindUsColors {
  static const Color primaryDark = Color(0xFF5D5343);
  static const Color background = Color(0xFFFDF7ED);
  static const Color textFieldBg = Color(0xFFFDF7ED);
  static const Color fieldBorder = Color(0xFFEADFCF);
  static const Color fieldIcon = Color(0xFFA69689);
  static const Color textMuted = Color(0xFF9E9181);
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FindUsColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header Melengkung (Hanya ada di Login)
            ClipPath(
              clipper: HeaderWaveClipper(),
              child: Container(
                height: 320,
                width: double.infinity,
                color: FindUsColors.primaryDark,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6),
                      ),
                      child: const Icon(
                        Icons.radio_button_checked,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'FinDUs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Konten Utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // 3. Tab Switcher
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2E7D5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        AuthTabWidget(
                          label: 'Log In',
                          isActive: true,
                          onTap: () {},
                        ),
                        AuthTabWidget(
                          label: 'Sign Up',
                          isActive: false,
                          onTap: () {
                            // Pindah ke Sign Up tanpa animasi agar terlihat seperti ganti tab
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a1, a2) =>
                                    const SignUpScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 4. Form Login
                  const AuthField(
                    icon: Icons.email_outlined,
                    label: 'Email address',
                  ),
                  const SizedBox(height: 16),
                  const AuthField(
                    icon: Icons.lock_outline,
                    label: 'Password',
                    isPassword: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: FindUsColors.textMuted),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryBtn(label: 'Log In', onTap: () {}),

                  const SizedBox(height: 32),

                  // 5. Divider "or"
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: FindUsColors.fieldBorder),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or',
                          style: TextStyle(color: FindUsColors.textMuted),
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: FindUsColors.fieldBorder),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // 6. Social Buttons
                  const Row(
                    children: [
                      Expanded(
                        child: SocialBtn(
                          icon: Icons.g_mobiledata,
                          label: 'Google',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: SocialBtn(icon: Icons.apple, label: 'Apple'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // 7. Footer
                  const Center(
                    child: Text(
                      'By signing up you agree to our Terms & Privacy',
                      style: TextStyle(
                        color: FindUsColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SHARED WIDGETS (Bisa dipakai juga di signup.dart)
// ═══════════════════════════════════════════════════════════════

class HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class AuthTabWidget extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const AuthTabWidget({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isActive ? FindUsColors.primaryDark : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : FindUsColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPassword;
  const AuthField({
    super.key,
    required this.icon,
    required this.label,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: FindUsColors.textMuted),
        prefixIcon: Icon(icon, color: FindUsColors.fieldIcon, size: 20),
        suffixIcon: isPassword
            ? const Icon(
                Icons.visibility_outlined,
                color: FindUsColors.fieldIcon,
                size: 20,
              )
            : null,
        filled: true,
        fillColor: FindUsColors.textFieldBg,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: FindUsColors.fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: FindUsColors.primaryDark),
        ),
      ),
    );
  }
}

class PrimaryBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const PrimaryBtn({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: FindUsColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SocialBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  const SocialBtn({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: FindUsColors.fieldBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
