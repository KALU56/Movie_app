import 'package:flutter/material.dart';
import '../core/assets.dart';
import '../core/movie_colors.dart';
import 'reset_password.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

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
                      'Enter Verification Code',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: MovieColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We sent a code to bimap22@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: MovieColors.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Verification Code Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: TextField(
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: MovieColors.primary,
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const Spacer(),

                // Verify Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ResetPassword()),
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
                  child: const Text('Verify Now'),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
