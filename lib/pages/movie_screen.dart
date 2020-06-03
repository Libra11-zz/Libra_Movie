import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/res/TextStyle.dart';
import 'package:libra_movie/response/movie_response.dart';
import 'package:libra_movie/state/multi_state.dart';
import 'package:libra_movie/state/sate_manager.dart';

class MovieScreen extends StatefulWidget {
  MovieScreen({Key key}) : super(key: key);
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  StateManager stateManager;
  MovieApi movieApi;
  @override
  void initState() {
    super.initState();
    stateManager = StateManager();
    movieApi = MovieApi();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    stateManager.dispose();
  }

  Future<MovieResponse> _loadData() async {
    MovieResponse response = await movieApi.getMovies();
    return response;
  }

  void loadData() {
    stateManager.loadingDialog();
    _loadData().then((v) {
      stateManager.content(v);
    }).catchError((e) {
      stateManager.error();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MultiStateWidget<MovieResponse>(
      streamController: stateManager.streamController,
      contentBuilder: (context, data) {
        return Container(
            padding: EdgeInsets.only(
                top: ScreenUtil.getStatusBarH(context) + 10,
                left: 10,
                right: 10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Movie', style: TextStyles.textBold24),
                    Icon(Icons.search, size: 24)
                  ],
                )
              ],
            ));
      },
    ));
  }
}
