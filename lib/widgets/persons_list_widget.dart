import 'dart:async';

import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/models/person_model.dart';
import 'package:libra_movie/res/TextStyle.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';

GlobalKey<_PersonsListState> personsListKey = GlobalKey();

class PersonsList extends StatefulWidget {
  PersonsList({Key key}) : super(key: key);

  @override
  _PersonsListState createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
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

  Future<PersonModel> _loadData() async {
    PersonModel response = await movieApi.getPersons();
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
  return Column(children: <Widget>[
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
      Text(AppLocalizations.of(context).translate('Person'),
          style: TextStyles.textBold16),
      Container(
        child: Row(
          children: <Widget>[
            Text(
              '${AppLocalizations.of(context).translate('More')} ',
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
    Container(
      height: 116,
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(top: 10, left: 8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  data.results[index].profileImg == null
                      ? Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: Icon(Icons.verified_user),
                        )
                      : Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w200" +
                                          data.results[index].profileImg),
                                  fit: BoxFit.cover)),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(data.results[index].name,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                  SizedBox(height: 3.0),
                ]),
          );
        },
      ),
    ),
  ]);
}
