class MovieResponse {
  final Map<String, dynamic> movies;
  final String error;

  MovieResponse({this.movies, this.error});

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = json,
        error = "";

  MovieResponse.withError(String errorValue)
      : movies = Map(),
        error = errorValue;
}
