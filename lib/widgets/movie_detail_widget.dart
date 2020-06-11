import 'dart:async';

import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/models/video_model.dart';
import 'package:libra_movie/pages/video_player_screen.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailWidget extends StatefulWidget {
  final int movieId;
  MovieDetailWidget({Key key, @required this.movieId}) : super(key: key);
  @override
  _MovieDetailWidgetState createState() => _MovieDetailWidgetState(movieId);
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  final int movieId;
  _MovieDetailWidgetState(this.movieId);
  StreamController<NetState> streamController;
  StateManager stateManager;
  MovieApi movieApi;

  @override
  void initState() {
    super.initState();
    stateManager = StateManager();
    movieApi = MovieApi();
    loadData();
  }

  Future<VideoModel> _loadData() async {
    VideoModel response = await movieApi.getVideos(movieId);
    print(response);
    return response;
  }

  void loadData() {
    stateManager.loading();
    _loadData().then((v) {
      if (v == null) {
        stateManager.error();
      } else {
        stateManager.content(v);
      }
    }).catchError((e) {
      stateManager.error();
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
    stateManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NetState>(
        stream: stateManager.streamController.stream,
        builder: (context, snap) {
          Widget result;
          if (snap.data != null) {
            if (snap.data is LoadingState) {
              result = LoadingWidget();
            } else if (snap.data is ErrorState) {
              result = Error1Widget();
            } else if (snap.data is ContentState) {
              result = contentWidget(context, (snap.data as ContentState).t);
            }
          } else {
            result = Container();
          }
          return result;
        });
  }
}

Widget contentWidget(context, data) {
  return FloatingActionButton(
    backgroundColor: Colors.orangeAccent,
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(
            controller: YoutubePlayerController(
              initialVideoId: data.videos[0].key,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: true,
              ),
            ),
          ),
        ),
      );
    },
    child: Icon(
      Icons.play_arrow,
      color: Colors.white,
    ),
  );
}
