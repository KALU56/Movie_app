import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieApi {
  static const String apiKey = '9e0200b7fad22edecb4aba6d587efbb4'; // Get from https://www.themoviedb.org/
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies(String category) async {
    final endpoint = category == 'All'
        ? '/movie/popular'
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