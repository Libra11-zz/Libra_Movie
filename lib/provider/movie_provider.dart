import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:flutter/material.dart';
import 'package:libra_movie/models/movie_model.dart';

class MovieProvider extends ChangeNotifier {
  Client client = Client();
  final apiKey = '4e3aff24e8a43ae7d0fda09987f47fe3';
  final baseUrl = 'https://api.themoviedb.org/3/discover/movie';

  Future<MovieModel> fetchMovieList() async {
    print('response');
    MovieModel movieModel;
    final response = await client
        .get('$baseUrl?api_key=$apiKey&language=zh&sort_by=popularity.desc');
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      movieModel = MovieModel.fromJson(json.decode(response.body));
      notifyListeners();
      return movieModel;
    } else {
      notifyListeners();
      throw Exception("获取电影列表失败");
    }
  }
}
