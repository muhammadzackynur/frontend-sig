import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart'; // Import login.dart untuk menggunakan FindUsColors & Shared Widgets

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 1. Inisialisasi Controller untuk menangkap input teks
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  // 2. Fungsi untuk mengirim data ke API Laravel
  Future<void> register() async {
    // Validasi apakah password dan konfirmasi password cocok
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password dan Confirm Password tidak cocok!'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Gunakan 10.0.2.2 jika menggunakan emulator Android
      final response = await http.post(
        Uri.parse('http://192.168.1.10/findus-backend/public/api/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json', // <-- TAMBAHKAN BARIS INI
        },
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phone': phoneController
              .text, // Hapus komentar ini jika backend Anda juga menerima input nomor HP
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi Berhasil! Silakan Log In.')),
        );

        // Pindah ke halaman Login setelah berhasil
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) => const LoginScreen(),
            transitionDuration: Duration.zero,
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal: ${data['message'] ?? 'Periksa kembali data Anda'}',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan koneksi server.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget dihancurkan untuk menghindari memory leak
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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

                  // 5. Form Sign Up (Ditambahkan parameter controller)
                  AuthField(
                    controller: nameController,
                    icon: Icons.person_outline,
                    label: 'Full Name',
                  ),
                  const SizedBox(height: 16),
                  AuthField(
                    controller: emailController,
                    icon: Icons.email_outlined,
                    label: 'Email address',
                  ),
                  const SizedBox(height: 16),
                  AuthField(
                    controller: phoneController,
                    icon: Icons.phone_android_outlined,
                    label: 'Phone Number',
                  ),
                  const SizedBox(height: 16),
                  AuthField(
                    controller: passwordController,
                    icon: Icons.lock_outline,
                    label: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  AuthField(
                    controller: confirmPasswordController,
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

                  // Tombol dengan indikator loading
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryBtn(
                          label: 'Create Account',
                          onTap: register, // Panggil fungsi register
                        ),

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
