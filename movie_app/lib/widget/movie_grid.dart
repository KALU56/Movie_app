import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_api.dart';
import '../models/movie_model.dart';
import 'movie_poster.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final MovieApi movieApi;

  const MovieGrid({
    super.key,
    required this.movies,
    required this.movieApi,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MoviePoster(
          movie: movie,
          movieApi: movieApi,
        );
      },
    );
  }
}