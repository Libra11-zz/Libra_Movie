class Result {
  String voteCount;
  bool video;
  int id;
  double voteAvarege;
  String title;
  double popularity;
  String posterPath;
  List<int> genreIds = [];
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Result(result) {
    voteCount = result['vote_count'].toString();
    video = result['video'];
    id = result['id'];
    voteAvarege = result['vote_average'].toDouble();
    title = result['title'].toString();
    popularity = result['popularity'].toDouble();
    posterPath = result['poster_path'].toString();
    for (var i = 0; i < result['genre_ids'].length; i++) {
      genreIds.add(result['genre_ids'][i]);
    }
    backdropPath = result['backdrop_path'].toString();
    adult = result['adult'];
    overview = result['overview'].toString();
    releaseDate = result['release_date'].toString();
  }
  String get getReleaseDate => releaseDate;
  String get getOverview => overview;
  bool get getAdult => adult;
  String get getBackdropPath => backdropPath;
  List<int> get getGenreIds => genreIds;
  String get getPosterPath => posterPath;
  double get getPopularity => popularity;
  String get getTitle => title;
  double get getVoteAvarege => voteAvarege;
  int get getId => id;
  bool get isVideo => video;
  String get getVoteCount => voteCount;
}
