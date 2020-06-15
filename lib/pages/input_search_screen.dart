import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/pages/movie_detail_screen.dart';
import 'package:libra_movie/res/Colors.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';
import 'package:libra_movie/widgets/movie_item_horizontal.dart';

class InputSearchScreen extends StatefulWidget {
  @override
  _InputSearchScreenState createState() => _InputSearchScreenState();
}

class _InputSearchScreenState extends State<InputSearchScreen> {
  TextEditingController _controller = TextEditingController();
  MovieApi movieApi = MovieApi();
  StateManager stateManager = StateManager();
  Future<MovieModel> _loadData(String query) async {
    MovieModel response = await movieApi.getSearchMovie(query);
    print(response);
    return response;
  }

  void loadData(String query) {
    stateManager.loading();
    _loadData(query).then((v) {
      if (v == null) {
        stateManager.error();
      } else {
        stateManager.content(v);
      }
    }).catchError((e) {
      stateManager.error();
    });
  }

  Color iconColor() {
    String th = SpUtil.getString(Constant.theme);
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    Color res;
    if (th == 'Light') {
      res = Colours.dark_bg_color;
    } else if (th == 'Dark') {
      res = Colors.white;
    } else if (th == 'System' && isDark) {
      res = Colors.white;
    } else {
      res = Colours.dark_bg_color;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        SizedBox(
          height: ScreenUtil.getStatusBarH(context),
        ),
        Container(
          width: ScreenUtil.getScreenH(context),
          height: 60,
          alignment: Alignment.center,
          child: TextField(
            controller: _controller,
            onChanged: (val) {
              if (val != "") {
                loadData(val);
              }
            },
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.none),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.none),
              ),
              hintText: AppLocalizations.of(context).translate('EnterMovie'),
              suffixIcon: IconButton(
                onPressed: () => _controller.clear(),
                icon: Icon(
                  Icons.clear,
                  color: iconColor(),
                ),
              ),
              prefixIcon: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: iconColor(),
                ),
              ),
            ),
          ),
        ),
        StreamBuilder<NetState>(
            stream: stateManager.streamController.stream,
            builder: (context, snap) {
              Widget result;
              if (snap.data != null) {
                if (snap.data is LoadingState) {
                  result = LoadingWidget();
                } else if (snap.data is ErrorState) {
                  result = Error1Widget();
                } else if (snap.data is ContentState) {
                  result =
                      contentWidget(context, (snap.data as ContentState).t);
                }
              } else {
                result = Container();
              }
              return result;
            })
      ]),
    );
  }
}

Widget contentWidget(context, data) {
  return Expanded(
    child: MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
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
            child: MovieItemHorizontal(
                data.results[index].posterPath,
                data.results[index].title,
                data.results[index].overview,
                data.results[index].voteAvarege),
          );
        },
      ),
    ),
  );
}
