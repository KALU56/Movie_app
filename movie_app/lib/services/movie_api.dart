import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieApi {
  static const String apiKey = '9e0200b7fad22edecb4aba6d587efbb4';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies(String category) async {
    final endpoint = _getEndpoint(category);
    final response = await http.get(Uri.parse('$baseUrl$endpoint?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).map((json) => Movie.fromJson(json)).toList();
    }
    throw Exception('Failed to load movies');
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).map((json) => Movie.fromJson(json)).toList();
    }
    throw Exception('Failed to load search results');
  }

  String _getEndpoint(String category) {
    switch (category) {
      case 'Popular':
        return '/movie/popular';
      case 'Top Rated':
        return '/movie/top_rated';
      case 'All':
        return '/movie/popular';
      default:
        return '/discover/movie?with_genres=${_getGenreId(category)}';
    }
  }

  int _getGenreId(String category) {
    switch (category) {
      case 'Comedy': return 35;
      case 'Romance': return 10749;
      case 'Fantastic': return 14;
      case 'Action': return 28;
      case 'Drama': return 18;
      case 'Advanced': return 12; // Adventure
      default: return 0;
    }
  }
}