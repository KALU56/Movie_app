import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/moviedetail.dart';
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

  late Future<List<Movie>> futurePopularMovies;
  late Future<List<Movie>> futureTopRatedMovies;
  final MovieApi movieApi = MovieApi();

  @override
  void initState() {
    super.initState();
    futurePopularMovies = movieApi.fetchMovies('Popular');
    futureTopRatedMovies = movieApi.fetchMovies('Top Rated');
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
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

              // Category Filter
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
              const SizedBox(height: 20),

              // Popular Movies Horizontal List
              const Text(
                'Popular Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: FutureBuilder<List<Movie>>(
                  future: futurePopularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No movies found'));
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final movie = snapshot.data![index];
                          return Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 10),
                            child: MoviePoster(movie: movie, movieApi: movieApi,),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Top Rated Movies Horizontal List
              const Text(
                'Top Rated',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: FutureBuilder<List<Movie>>(
                  future: futureTopRatedMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No movies found'));
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final movie = snapshot.data![index];
                          return Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 10),
                            child: MoviePoster(
                              movie: movie,
                              movieApi: movieApi,
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),

              // All Movies Grid
              const Text(
                'All Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Movie>>(
                future: movieApi.fetchMovies(selectedCategory),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final movie = snapshot.data![index];
                        return MoviePoster(movie: movie, movieApi: movieApi,);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MoviePoster extends StatelessWidget {
  final Movie movie;
  final MovieApi movieApi;

  const MoviePoster({
    super.key, 
    required this.movie,
    required this.movieApi,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final detailedMovie = await movieApi.fetchMovieDetails(movie.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: detailedMovie),
          ),
        );
      },
      child: ClipRRect(
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
      ),
    );
  }
}