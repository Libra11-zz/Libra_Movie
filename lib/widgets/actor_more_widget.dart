import 'dart:async';

import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/models/person_detail.dart';
import 'package:libra_movie/models/person_model.dart';
import 'package:libra_movie/pages/actor_detail_screen.dart';
import 'package:libra_movie/res/TextStyle.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/actor_more_item.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';

class ActorMoreWidget extends StatefulWidget {
  @override
  _ActorMoreWidgetState createState() => _ActorMoreWidgetState();
}

class _ActorMoreWidgetState extends State<ActorMoreWidget> {
  int page = 1;
  StreamController<NetState> streamController;
  StateManager stateManager;
  MovieApi movieApi;
  ScrollController scrollController;
  PersonModel response;
  bool isLoading = false;
  bool error = false;

  @override
  void initState() {
    super.initState();
    stateManager = StateManager();
    movieApi = MovieApi();
    scrollController = ScrollController();
    loadData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // 加载更多
        setState(() {
          isLoading = true;
          error = false;
        });
        movieApi.getPersons(page: page + 1).then((val) {
          page = val.page;
          setState(() {
            isLoading = false;
            response.results.addAll(val.results);
          });
        }).catchError((e) {
          setState(() {
            error = true;
          });
        });
      }
    });
  }

  Future<PersonModel> _loadData() async {
    response = await movieApi.getPersons(page: page);
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
              result = contentWidget(context, (snap.data as ContentState).t,
                  scrollController, isLoading, error);
            }
          } else {
            result = Container();
          }
          return result;
        });
  }
}

Widget contentWidget(context, data, controller, isLoading, error) {
  return Column(children: <Widget>[
    Row(children: <Widget>[
      Text(AppLocalizations.of(context).translate('Actor'),
          style: TextStyles.textBold16),
      SizedBox(
        width: 10,
      ),
      Text(data.totalResults.toString())
    ]),
    SizedBox(
      height: 10,
    ),
    Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ActorDetail(actor: data.results[index])));
            },
            child: ActorMoreItem(actor: data.results[index]),
          );
        },
      ),
    ),
    isLoading
        ? CircularProgressIndicator(
            value: null,
            strokeWidth: 1.0,
          )
        : Container(),
    error ? Text('error') : Container()
  ]);
}
