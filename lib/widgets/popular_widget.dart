import 'dart:async';

import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/res/TextStyle.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';
import 'package:libra_movie/widgets/movie_item_horizontal.dart';
import 'package:libra_movie/widgets/movie_item_vertical.dart';

class Popular extends StatefulWidget {
  Popular({Key key}) : super(key: key);

  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
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

  Future<MovieModel> _loadData() async {
    MovieModel response = await movieApi.getMovies();
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
          }
          return result;
        });
  }
}

Widget contentWidget(context, data) {
  return Stack(children: <Widget>[
    SizedBox(height: 20),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
      Text('Popular', style: TextStyles.textBold16),
      Container(
        child: Row(
          children: <Widget>[
            Text(
              'All ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.title.color),
            ),
            Text(data.totalResults.toString(),
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.title.color)),
            Icon(Icons.chevron_right,
                color: Theme.of(context).textTheme.title.color)
          ],
        ),
      )
    ]),
    SizedBox(height: 8),
    MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: data.results.length,
          itemBuilder: (BuildContext context, int index) {
            return MovieItemHorizontal(
                data.results[index].posterPath,
                data.results[index].title,
                data.results[index].overview,
                data.results[index].voteAvarege);
          },
        ),
      ),
    )
  ]);
}
