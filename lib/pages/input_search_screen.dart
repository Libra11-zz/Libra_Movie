import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/res/Colors.dart';

class InputSearchScreen extends SearchDelegate<String> {
  MovieApi movieApi = MovieApi();
  Future<MovieModel> _loadData(String q) async {
    MovieModel response = await movieApi.getSearchMovie(q);
    return response;
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
    var res;
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
    Widget widget;
    _loadData(query).then((v) {
      print(v.toString());
      if (v == null) {
        widget = Text('没有结果');
      } else {
        widget = ListView.builder(
            itemCount: v.results.length,
            itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.movie),
                title: Text(v.results[index].title)));
      }
    }).catchError((e) {
      widget = Text('error');
    });
    return widget;
  }
}
