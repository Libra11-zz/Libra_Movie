import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/pages/movie_detail_screen.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';
import 'package:page_indicator/page_indicator.dart';

GlobalKey<_UpcomingState> upcomingKey = GlobalKey();

class Upcoming extends StatefulWidget {
  Upcoming({Key key}) : super(key: key);

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
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
    MovieModel response = await movieApi.getUpcoming();
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
  return Container(
    height: 220.0,
    child: PageIndicatorContainer(
      align: IndicatorAlign.bottom,
      length: data.results.take(5).length,
      indicatorSpace: 8.0,
      padding: const EdgeInsets.all(5.0),
      indicatorColor: Colors.white,
      indicatorSelectorColor: Colors.orangeAccent,
      shape: IndicatorShape.circle(size: 5.0),
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.results.take(5).length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailScreen(movie: data.results[index])));
            },
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: data.results[index].id,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/original/" +
                                    data.results[index].backdropPath)),
                      )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Positioned(
                    bottom: 0.0,
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Icon(
                      FontAwesomeIcons.playCircle,
                      color: Colors.orangeAccent,
                      size: 40.0,
                    )),
                Positioned(
                    bottom: 10.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data.results[index].title,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          Text(
                            data.results[index].releaseDate,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    ),
  );
}
