import 'dart:async';

import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/models/person_video_model.dart';
import 'package:libra_movie/pages/movie_detail_screen.dart';
import 'package:libra_movie/res/TextStyle.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';
import 'package:libra_movie/widgets/movie_item_vertical.dart';

class PersonVideo extends StatefulWidget {
  final int id;
  PersonVideo({Key key, @required this.id}) : super(key: key);
  @override
  _PersonVideoState createState() => _PersonVideoState(id);
}

class _PersonVideoState extends State<PersonVideo> {
  final int id;
  _PersonVideoState(this.id);
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

  Future<PersonVideoModel> _loadData() async {
    PersonVideoModel response = await movieApi.getPersonVideo(id);
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
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(children: <Widget>[
      SizedBox(
        height: 10,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        Text('代表作', style: TextStyles.textBold16),
      ]),
      SizedBox(height: 10),
      Container(
        height: 295,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.results.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailScreen(movie: data.results[index])));
              },
              child: MovieItemVertical(data.results[index].posterPath,
                  data.results[index].title, data.results[index].voteAvarege),
            );
          },
        ),
      ),
    ]),
  );
}
