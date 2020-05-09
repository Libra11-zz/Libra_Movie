class MovieModel {
  int page;
  int totalPages;
  int totalResults;
  List<Result> results = [];

  MovieModel({this.page, this.totalPages, this.totalResults, this.results});

  MovieModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    for (var i = 0; i < json['results'].length; i++) {
      Result result = Result(json['results'][i]);
      results.add(result);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    data['results'] = this.results;
    return data;
  }
}

class Result {
  String voteCount;
  bool video;
  int id;
  var voteAvarege;
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
    voteAvarege = result['vote_avarege'];
    title = result['title'].toString();
    popularity = result['popularity'];
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
  String get getVoteAvarege => voteAvarege;
  int get getId => id;
  bool get isVideo => video;
  String get getVoteCount => voteCount;
}
