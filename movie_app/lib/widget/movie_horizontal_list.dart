import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_api.dart';
import '../models/movie_model.dart';
import 'movie_poster.dart';

class MovieHorizontalList extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final MovieApi movieApi;

  const MovieHorizontalList({
    super.key,
    required this.title,
    required this.movies,
    required this.movieApi,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 10),
                child: MoviePoster(
                  movie: movie,
                  movieApi: movieApi,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}