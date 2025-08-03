import 'package:flutter/material.dart';
import '../core/movie_colors.dart';

class Siginup extends StatefulWidget {
  const Siginup({super.key});

  @override
  State<Siginup> createState() => _SiginupState();
}

class _SiginupState extends State<Siginup> {
  bool _obscurePassword = true;

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
                  const SizedBox(height: 25),

                  // Name Field
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: MovieColors.secondary),
                      hintText: 'Your name',
                      hintStyle: const TextStyle(color: MovieColors.secondary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),

                  const SizedBox(height: 10),

                  // Email Field
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email, color: MovieColors.secondary),
                      hintText: 'Enter your email',
                      hintStyle: const TextStyle(color: MovieColors.secondary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 10),

                  // Password Field
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: MovieColors.secondary),
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(color: MovieColors.secondary),
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

                  const SizedBox(height: 10),

                  // Confirm Password Field
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: MovieColors.secondary),
                      hintText: 'Confirm your password',
                      hintStyle: const TextStyle(color: MovieColors.secondary),
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

                  const SizedBox(height: 10),

                  // Password Requirements
                  const Text('• At least 8 characters', style: TextStyle(color: MovieColors.secondary)),
                  const Text('• At least 1 number', style: TextStyle(color: MovieColors.secondary)),
                  const Text('• Both upper and lower case letters', style: TextStyle(color: MovieColors.secondary)),

                  const SizedBox(height: 30),

                  // Terms Text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'By signing up you agree to our Terms of Service and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: MovieColors.secondary),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MovieColors.accent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Center(child: Text('Sign Up')),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
