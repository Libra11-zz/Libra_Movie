import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/res/Colors.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';

class InputSearchScreen extends SearchDelegate<String> {
  MovieApi movieApi = MovieApi();
  StateManager stateManager = StateManager();
  Future<MovieModel> _loadData() async {
    MovieModel response = await movieApi.getSearchMovie(query);
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
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  // 搜索条黑夜模式适配
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String th = SpUtil.getString(Constant.theme);
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    Color res;
    if (th == 'Light') {
      res = Colors.orangeAccent;
    } else if (th == 'Dark') {
      res = Colours.dark_bg_color;
    } else if (th == 'System' && isDark) {
      res = Colours.dark_bg_color;
    } else {
      res = Colors.orangeAccent;
    }
    return theme.copyWith(primaryColor: res);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();
    loadData();
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
  return ListView.builder(
    shrinkWrap: true,
    // scrollDirection: Axis.vertical,
    physics: NeverScrollableScrollPhysics(),
    itemCount: data.results.length,
    itemBuilder: (BuildContext context, int index) {
      return Text(data.results[index].title);
    },
  );
}
