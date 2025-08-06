import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // ✅ Fixed the error here (removed the extra single quote)
import '../core/movie_colors.dart';
import '../widget/category_button.dart';
import '../models/movie_model.dart';
import '../services/movie_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  final categories = [
    'All',
    'Advanced',
    'Comedy',
    'Romance',
    'Fantastic',
    'Action',
    'Drama',
  ];

  late Future<List<Movie>> futureMovies;
  final MovieApi movieApi = MovieApi();

  @override
  void initState() {
    super.initState();
    futureMovies = movieApi.fetchMovies(selectedCategory);
  }

  void _fetchMoviesByCategory(String category) {
    setState(() {
      selectedCategory = category;
      futureMovies = movieApi.fetchMovies(category);
    });
  }

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
                style: TextStyle(color: Colors.white, fontSize: 24),
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
            // 🔍 Search Bar
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

            // 🏷️ Category Filter
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((label) {
                  return CategoryButton(
                    label: label,
                    isSelected: selectedCategory == label,
                    onPressed: () => _fetchMoviesByCategory(label),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // 🎬 Movie Grid
            Expanded(
              child: FutureBuilder<List<Movie>>(
                future: futureMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  } else {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final movie = snapshot.data![index];
                        return MoviePoster(movie: movie);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final Movie movie;

  const MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.fullPosterPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.broken_image)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Text(
                movie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
