import 'package:flutter/material.dart';
import '../core/movie_colors.dart';
import '../widgt/category_button.dart';


class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  final categories = ['All', 'Advanced', 'Comedy', 'Romance', 'Fantastic', 'Action', 'Drama'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MovieColors.background,
      drawer: Drawer(
        backgroundColor: MovieColors.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: MovieColors.accent),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie, color: Colors.white),
              title: Text('Movies', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.tv, color: Colors.white),
              title: Text('Series', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.star, color: Colors.white),
              title: Text('Favorites', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          children: [
   
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: MovieColors.secondary.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: MovieColors.secondary),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search movies, series, shows...',
                        hintStyle: TextStyle(color: MovieColors.secondary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: MovieColors.secondary),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((label) {
                  return CategoryButton(
                    label: label,
                    isSelected: selectedCategory == label,
                    onPressed: () {
                      setState(() {
                        selectedCategory = label;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
