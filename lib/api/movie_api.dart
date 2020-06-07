import 'package:flustars/flustars.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:dio/dio.dart';

class MovieApi {
  final String apiKey = "4e3aff24e8a43ae7d0fda09987f47fe3";
  static String mainUrl = 'https://api.themoviedb.org/3';
  String getPopularUrl = '/movie/top_rated';
  String getMoviesUrl = '';
  String getPlayingUrl = '/movie/now_playing';
  String getGenresUrl = '';
  String getPersonsUrl = '';
  Dio dio;
  String language;
  MovieApi() {
    language = SpUtil.getString(Constant.language) == 'zh' ? 'zh' : 'en-US';
    print(language);
    BaseOptions options = new BaseOptions(
      baseUrl: mainUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = new Dio(options);
  }

  Future<MovieModel> getMovies() async {
    Map<String, Object> params = {
      'api_key': apiKey,
      'language': language,
      'page': 1
    };
    try {
      Response response =
          await dio.request(getPopularUrl, queryParameters: params);
      return MovieModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stacktrace: $stacktrace');
      return null;
    }
  }

  Future<MovieModel> getNowPalying() async {
    Map<String, Object> params = {
      'api_key': apiKey,
      'language': language,
      'page': 1
    };
    try {
      Response response =
          await dio.request(getPlayingUrl, queryParameters: params);
      return MovieModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stacktrace: $stacktrace');
      return null;
    }
  }
}
