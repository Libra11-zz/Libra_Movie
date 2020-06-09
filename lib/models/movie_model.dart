import 'package:libra_movie/models/result_model.dart';

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
