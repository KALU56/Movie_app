// screens/home.dart
import 'package:flutter/material.dart';
import '../core/movie_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MovieColors.background,
      appBar: AppBar(
        backgroundColor: MovieColors.primary,
        title: const Text(
          'Welcome Home',
          style: TextStyle(color: MovieColors.highlight),
        ),
      ),
      body: const Center(
        child: Text(
          'You are now logged in!',
          style: TextStyle(
            fontSize: 20,
            color: MovieColors.secondary,
          ),
        ),
      ),
    );
  }
}
