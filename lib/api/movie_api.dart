import 'package:libra_movie/response/movie_response.dart';
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
  MovieApi() {
    BaseOptions options = new BaseOptions(
      baseUrl: mainUrl,
      connectTimeout: 15000,
      receiveTimeout: 3000,
    );
    dio = new Dio(options);
  }

  Future<MovieResponse> getMovies() async {
    Map<String, Object> params = {
      'api_key': apiKey,
      'language': 'en-Us',
      'page': 1
    };
    try {
      Response response =
          await dio.request(getPopularUrl, queryParameters: params);
      print(response.data);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stacktrace: $stacktrace');
      return MovieResponse.withError(error.toString());
    }
  }
}
