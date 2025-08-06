import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  movie.fullBackdropPath,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        movie.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.calendar_today, size: 20, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        movie.releaseDate ?? 'N/A',
                        style: const TextStyle(color: Colors.white),
                      ),
                      if (movie.runtime != null) ...[
                        const SizedBox(width: 20),
                        const Icon(Icons.timer, size: 20, color: Colors.white),
                        const SizedBox(width: 5),
                        Text(
                          '${movie.runtime} min',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (movie.genres != null && movie.genres!.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: movie.genres!
                          .map((genre) => Chip(
                                label: Text(genre),
                                backgroundColor: Colors.amber,
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.overview ?? 'No overview available',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}