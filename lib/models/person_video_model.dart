import 'package:libra_movie/models/result_model.dart';

class PersonVideoModel {
  List<Result> results = [];

  PersonVideoModel({this.results});

  PersonVideoModel.fromJson(Map<String, dynamic> json) {
    for (var i = 0; i < json['cast'].length; i++) {
      Result result = Result(json['cast'][i]);
      results.add(result);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    return data;
  }
}
