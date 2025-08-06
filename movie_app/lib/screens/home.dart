import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widget/category_button.dart';
import 'package:movie_app/widget/movie_grid.dart';
import 'package:movie_app/widget/movie_horizontal_list.dart';
import 'package:movie_app/widget/search_bar.dart'; 
import '../services/movie_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieApi movieApi = MovieApi();
  final categories = ['All', 'Advanced', 'Comedy', 'Romance', 'Fantastic', 'Action', 'Drama'];
  String selectedCategory = 'All';
  bool isSearching = false;
  List<Movie> searchResults = [];

  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> categoryMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = movieApi.fetchMovies('Popular');
    topRatedMovies = movieApi.fetchMovies('Top Rated');
    categoryMovies = movieApi.fetchMovies(selectedCategory);
  }

  void _handleSearch(String query) async {
    if (query.isEmpty) {
      setState(() => isSearching = false);
      return;
    }

    setState(() => isSearching = true);
    final results = await movieApi.searchMovies(query);
    setState(() => searchResults = results);
  }

  void _handleCategoryChange(String category) {
    setState(() {
      selectedCategory = category;
      categoryMovies = movieApi.fetchMovies(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: _buildDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          children: [
                SearchBar(
                  onSearch: (query) {
                    print("Search text: $query");
                  },
                  onMenuPressed: () {
                    print("Menu button pressed");
                  },
                  onClearSearch: () {
                    print("Clear search");
                  },
                ),
            const SizedBox(height: 20),
            
            if (isSearching)
              Expanded(child: _buildSearchResults())
            else
              Expanded(child: _buildMainContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: Text('Menu', style: TextStyle(color: Colors.black, fontSize: 24)),
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
    );
  }

  Widget _buildSearchResults() {
    return MovieGrid(
      movies: searchResults,
      movieApi: movieApi,
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((label) => CategoryButton(
              label: label,
              isSelected: selectedCategory == label,
              onPressed: () => _handleCategoryChange(label),
            )).toList(),
          ),
        ),
        const SizedBox(height: 20),
        
        FutureBuilder<List<Movie>>(
          future: popularMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontalList(
                title: 'Popular Movies',
                movies: snapshot.data!,
                movieApi: movieApi,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        const SizedBox(height: 20),
        
        FutureBuilder<List<Movie>>(
          future: topRatedMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontalList(
                title: 'Top Rated',
                movies: snapshot.data!,
                movieApi: movieApi,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        const SizedBox(height: 20),
        
        FutureBuilder<List<Movie>>(
          future: categoryMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All Movies',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  MovieGrid(
                    movies: snapshot.data!,
                    movieApi: movieApi,
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}