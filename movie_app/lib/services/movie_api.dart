
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieApi {
  static const String apiKey = '9e0200b7fad22edecb4aba6d587efbb4'; // Replace with your actual API key
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies(String category) async {
    final endpoint = category == 'All'
        ? '/movie/popular'
        : category == 'Popular'
            ? '/movie/popular'
            : category == 'Top Rated'
                ? '/movie/top_rated'
                : '/discover/movie?with_genres=${_getGenreId(category)}';

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
Future<Movie> fetchMovieDetails(int movieId) async {
  final response = await http.get(
    Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Movie.fromJson(data);
  } else {
    throw Exception('Failed to load movie details');
  }
}
Future<List<Movie>> searchMovies(String query) async {
  final response = await http.get(
    Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return (data['results'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load search results');
  }
}
  // Separate methods for specific movie lists
  Future<List<Movie>> fetchPopularMovies() async {
    return fetchMovies('Popular');
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    return fetchMovies('Top Rated');
  }

  int _getGenreId(String category) {
    switch (category) {
      case 'Comedy':
        return 35;
      case 'Romance':
        return 10749;
      case 'Fantastic':
        return 14;
      case 'Action':
        return 28;
      case 'Drama':
        return 18;
      case 'Advanced': // Assuming this means "Adventure"
        return 12;
      default:
        return 0;
    }
  }
}