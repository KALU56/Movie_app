class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String? backdropPath;
  final String? overview;
  final double? voteAverage;
  final String? releaseDate;
  final int? runtime;
  final List<String>? genres;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.backdropPath,
    this.overview,
    this.voteAverage,
    this.releaseDate,
    this.runtime,
    this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      overview: json['overview'],
      voteAverage: json['vote_average']?.toDouble(),
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      genres: (json['genres'] as List?)?.map((g) => g['name'].toString()).toList(),
    );
  }

  String get fullPosterPath => 'https://image.tmdb.org/t/p/w500$posterPath';
  String get fullBackdropPath => 'https://image.tmdb.org/t/p/w1280${backdropPath ?? posterPath}';
}