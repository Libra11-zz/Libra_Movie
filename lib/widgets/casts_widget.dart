import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/models/cast_model.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';

class Casts extends StatefulWidget {
  final int id;
  Casts({Key key, @required this.id}) : super(key: key);
  @override
  _CastsState createState() => _CastsState(id);
}

class _CastsState extends State<Casts> {
  final int id;
  _CastsState(this.id);
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

  Future<CastModel> _loadData() async {
    CastModel response = await movieApi.getCasts(id);
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
    height: 140.0,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.results.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(top: 10.0, right: 8.0),
          width: 100.0,
          child: GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                data.results[index].img == null
                    ? Hero(
                        tag: data.results[index].id,
                        child: Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Hero(
                        tag: data.results[index].id,
                        child: Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w300/" +
                                          data.results[index].img)),
                            )),
                      ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  data.results[index].name,
                  maxLines: 2,
                  style: TextStyle(
                      height: 1.4, fontWeight: FontWeight.bold, fontSize: 9.0),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  data.results[index].character,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.4, fontWeight: FontWeight.bold, fontSize: 7.0),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
