import 'package:flutter/material.dart';
import '../core/assets.dart';
import '../core/movie_colors.dart';
import './login_siginup.dart';

class Taskugas extends StatefulWidget {
  const Taskugas({super.key});

  @override
  State<Taskugas> createState() => _TaskugasState();
}

class _TaskugasState extends State<Taskugas> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Team Up For Success',
      'desc': 'Collaborate and conquer your goals together.',
      'image': Assets.image2,
    },
    {
      'title': 'User-Friendly at its Core',
      'desc': 'Designed for simplicity, built for productivity.',
      'image': Assets.image3,
    },
    {
      'title': 'Easy Task Creation',
      'desc': 'Create, manage, and complete tasks effortlessly.',
      'image': Assets.image4,
    },
  ];

  void _nextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginSiginup()),
      );
    }
  }

  void _skip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginSiginup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MovieColors.background,
      body: Column(
        children: [
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.tag),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                'Movies',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: MovieColors.highlight,
                ),
              ),
            ],
          ),

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final item = onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(item['image']!, height: 300),
                      const SizedBox(height: 30),
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MovieColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item['desc']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: MovieColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: _currentIndex == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? MovieColors.accent
                      : MovieColors.secondary.withValues(),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MovieColors.accent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _nextPage,
              child: Text(
                _currentIndex == onboardingData.length - 1 ? 'Sign in' : 'Next',
              ),
            ),
          ),

          TextButton(
            onPressed: _skip,
            child: Text(
              _currentIndex == onboardingData.length - 1 ? 'Sign up' : 'Skip',
              style: const TextStyle(color: MovieColors.secondary),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
