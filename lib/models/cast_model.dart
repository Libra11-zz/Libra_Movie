class CastModel {
  List<Cast> results = [];

  CastModel({this.results});

  CastModel.fromJson(Map<String, dynamic> json) {
    for (var i = 0; i < json['cast'].length; i++) {
      Cast result = Cast(json['cast'][i]);
      results.add(result);
    }
  }
}

class Cast {
  int id;
  String character;
  String name;
  String img;

  Cast(result) {
    id = result["cast_id"];
    character = result["character"];
    name = result["name"];
    img = result["profile_path"];
  }

  Cast.fromJson(Map<String, dynamic> json)
      : id = json["cast_id"],
        character = json["character"],
        name = json["name"],
        img = json["profile_path"];
  int get getId => id;
  String get getName => name;
  String get getCharacter => character;
  String get getimg => img;
}
