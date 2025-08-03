import 'package:flutter/material.dart';
import '../core/assets.dart';
import '../core/movie_colors.dart';
import './verification.dart';
import './login_siginup.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [MovieColors.background, MovieColors.primary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Logo and Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'appLogo',
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.tag),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Taskugas',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: MovieColors.highlight,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Header Text
                Column(
                  children: const [
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: MovieColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Enter your email to reset your password',
                      style: TextStyle(
                        fontSize: 16,
                        color: MovieColors.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Illustration
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.forgot),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Email Field
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: MovieColors.secondary),
                    hintText: 'Enter your email',
                    hintStyle: const TextStyle(color: MovieColors.secondary),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white, width: 1.5),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 24),

                // Continue Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Verification()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MovieColors.accent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Continue'),
                ),

                const SizedBox(height: 12),

                // Cancel Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginSiginup()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: MovieColors.secondary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
