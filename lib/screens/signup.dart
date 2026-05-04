import 'package:flutter/material.dart';
import 'login.dart'; // Import login.dart untuk menggunakan FindUsColors & Shared Widgets

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FindUsColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header Melengkung (Sama seperti Login)
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
                          isActive: false,
                          onTap: () {
                            // Pindah kembali ke Login tanpa animasi
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a1, a2) =>
                                    const LoginScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                        AuthTabWidget(
                          label: 'Sign Up',
                          isActive: true,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 4. Teks Judul Sign Up
                  const Text(
                    'Create account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Join Circlee and start connecting.',
                    style: TextStyle(
                      color: FindUsColors.textMuted,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 5. Form Sign Up
                  const AuthField(
                    icon: Icons.person_outline,
                    label: 'Full Name',
                  ),
                  const SizedBox(height: 16),
                  const AuthField(
                    icon: Icons.email_outlined,
                    label: 'Email address',
                  ),
                  const SizedBox(height: 16),
                  const AuthField(
                    icon: Icons.phone_android_outlined,
                    label: 'Phone Number',
                  ),
                  const SizedBox(height: 16),
                  const AuthField(
                    icon: Icons.lock_outline,
                    label: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  const AuthField(
                    icon: Icons.lock_outline,
                    label: 'Confirm Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Use 8+ characters with a mix of letters, numbers & symbols.',
                    style: TextStyle(
                      fontSize: 11,
                      color: FindUsColors.textMuted,
                    ),
                  ),

                  const SizedBox(height: 24),
                  PrimaryBtn(label: 'Create Account', onTap: () {}),

                  const SizedBox(height: 32),

                  // 6. Divider "or"
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: FindUsColors.fieldBorder),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or continue with',
                          style: TextStyle(color: FindUsColors.textMuted),
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: FindUsColors.fieldBorder),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // 7. Social Buttons
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

                  // 8. Footer
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'By creating an account you agree to our',
                          style: TextStyle(
                            color: FindUsColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Terms of Service & Privacy Policy',
                          style: TextStyle(
                            color: Color(0xFFC8A982),
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a1, a2) =>
                                    const LoginScreen(),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(color: FindUsColors.textMuted),
                              children: [
                                TextSpan(
                                  text: 'Log In',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
