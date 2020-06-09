class Person {
  int id;
  double popularity;
  String name;
  String profileImg;
  String known;

  Person(result) {
    id = result['id'];
    popularity = result['popularity']?.toDouble();
    name = result['name'];
    profileImg = result['profile_path'];
    known = result['known_for_department'].toString();
  }

  int get getId => id;
  String get getName => name;
  String get getProfileImg => profileImg;
  double get getPopularity => popularity;
  String get getKnown => known;
}
