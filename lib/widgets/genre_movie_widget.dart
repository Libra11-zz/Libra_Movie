import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/pages/movie_detail_screen.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';

class GenreMovie extends StatefulWidget {
  final int genreId;
  GenreMovie({Key key, @required this.genreId}) : super(key: key);
  @override
  _GenreMovieState createState() => _GenreMovieState(genreId);
}

class _GenreMovieState extends State<GenreMovie> {
  final int genreId;
  _GenreMovieState(this.genreId);
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
    MovieModel response = await movieApi.getMovieByGenreId(genreId);
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
  return Container(
    height: 270.0,
    padding: EdgeInsets.only(left: 10.0),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.results.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailScreen(movie: data.results[index])));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: data.results[index].id,
                  child: Container(
                      width: 120.0,
                      height: 178.0,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w200/" +
                                    data.results[index].posterPath)),
                      )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 100,
                  child: Text(
                    data.results[index].title,
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RatingBar(
                      itemSize: 8.0,
                      initialRating: data.results[index].popularity / 2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        EvaIcons.star,
                        color: Colors.orangeAccent,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      data.results[index].voteAvarege.toString(),
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}
