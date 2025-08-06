import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/assets.dart';
import '../core/movie_colors.dart';
import '../screens/forgot_password.dart';
import '../screens/home.dart'; // 👈 Add this import

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // ✅ Navigate to Home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      // ❌ Show error as snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: MovieColors.accent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              color: MovieColors.background,
              child: Column(
                children: [
                  const SizedBox(height: 9),

                  // Apple Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image.asset(Assets.appleImage, height: 24, width: 24),
                        const SizedBox(width: 10),
                        const Text(
                          "Login with Apple",
                          style: TextStyle(color: MovieColors.primary),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Google Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image.asset(Assets.googleImage, height: 24, width: 24),
                        const SizedBox(width: 10),
                        const Text(
                          "Login with Google",
                          style: TextStyle(color: MovieColors.primary),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),
                  const Text(
                    'or continue with email',
                    style: TextStyle(color: MovieColors.secondary),
                  ),
                  const SizedBox(height: 15),

                  // Email Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email, color: MovieColors.secondary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 1.5),
                      ),
                      hintText: 'Enter your email',
                      hintStyle: const TextStyle(color: MovieColors.secondary),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  // Password Field
                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(color: MovieColors.secondary),
                      prefixIcon: const Icon(Icons.lock, color: MovieColors.secondary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 1.5),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: MovieColors.secondary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Forgot Password
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: MovieColors.accent,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Login Button
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MovieColors.accent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Text('Login'),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Terms and Privacy
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('By signing up you agree to our '),
                      Text(
                        'Terms of service',
                        style: TextStyle(
                          color: MovieColors.accent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('and '),
                      Text(
                        'privacy policy',
                        style: TextStyle(
                          color: MovieColors.accent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
