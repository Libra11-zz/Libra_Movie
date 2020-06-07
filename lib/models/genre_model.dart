class GenreModel {
  List<Genre> results = [];

  GenreModel({this.results});

  GenreModel.fromJson(Map<String, dynamic> json) {
    for (var i = 0; i < json['genres'].length; i++) {
      Genre result = Genre(json['genres'][i]);
      results.add(result);
    }
  }
}

class Genre {
  int id;
  String name;

  Genre(result) {
    id = result['id'];
    name = result['name'];
  }

  int get getId => id;
  String get getName => name;
}
