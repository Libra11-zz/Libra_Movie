class PersonModel {
  int page;
  int totalPages;
  int totalResults;
  List<Person> results = [];

  PersonModel({this.page, this.totalPages, this.totalResults, this.results});

  PersonModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    for (var i = 0; i < json['results'].length; i++) {
      Person result = Person(json['results'][i]);
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
