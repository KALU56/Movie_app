import 'package:flutter/material.dart';
import '../core/assets.dart';
import '../core/movie_colors.dart';
import '../widgt/login.dart';
import '../widgt/siginup.dart';

class LoginSiginup extends StatefulWidget {
  const LoginSiginup({super.key});

  @override
  State<LoginSiginup> createState() => _LoginSiginupState();
}

class _LoginSiginupState extends State<LoginSiginup> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MovieColors.background,
      body: Column(
        children: [
          const SizedBox(height: 60),

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
                'Movies',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: MovieColors.highlight,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Tab Switcher with accent color
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTab(title: 'Login', selected: isLogin, onTap: () {
                setState(() => isLogin = true);
              }),
              const SizedBox(width: 20),
              _buildTab(title: 'Sign Up', selected: !isLogin, onTap: () {
                setState(() => isLogin = false);
              }),
            ],
          ),

          const SizedBox(height: 20),

          // Animated form switcher
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: isLogin ? const Login() : const Siginup(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? MovieColors.accent : MovieColors.secondary,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 2,
            width: selected ? 40 : 0,
            color: MovieColors.accent,
            margin: const EdgeInsets.only(top: 4),
          ),
        ],
      ),
    );
  }
}
