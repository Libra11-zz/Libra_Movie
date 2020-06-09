class PersonDetail {
  final String birthday;
  final String known;
  final String biography;
  final String birth;
  final double popularity;
  PersonDetail(
      this.biography, this.known, this.birth, this.birthday, this.popularity);
  PersonDetail.fromJson(Map<String, dynamic> json)
      : birthday = json["birthday"],
        known = json["known_for_department"],
        biography = json["biography"],
        popularity = json["popularity"].toDouble(),
        birth = json["place_of_birth"];
}
