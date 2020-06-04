import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/res/Colors.dart';
import 'package:libra_movie/res/TextStyle.dart';
import 'package:libra_movie/state/multi_state.dart';
import 'package:libra_movie/state/sate_manager.dart';
import 'package:libra_movie/widgets/movie_item_vertical.dart';

Color firstColor = Color(0xFFF47D15);
TextStyle dropDownMenuItemStyle =
    TextStyle(color: Colors.white, fontSize: 16.0);

class MovieScreen extends StatefulWidget {
  MovieScreen({Key key}) : super(key: key);
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  StateManager stateManager;
  MovieApi movieApi;
  @override
  void initState() {
    super.initState();
    stateManager = StateManager();
    movieApi = MovieApi();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    stateManager.dispose();
  }

  Future<MovieModel> _loadData() async {
    MovieModel response = await movieApi.getMovies();
    return response;
  }

  void loadData() {
    stateManager.loadingDialog();
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
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: ScreenUtil.getStatusBarH(context) + 10, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 80,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Movie',
                      textAlign: TextAlign.left, style: TextStyles.textBold24),
                )),
            Material(
              elevation: 2.0,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3), bottomLeft: Radius.circular(3)),
              child: TextField(
                controller: TextEditingController(text: ''),
                cursorColor: firstColor,
                decoration: InputDecoration(
                    hintText: 'search movies......',
                    filled: true,
                    border: InputBorder.none,
                    suffixIcon: Material(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(3),
                            bottomRight: Radius.circular(3)),
                        child: Container(
                            // Material 默认使用的Canvas的颜色 这里将颜色改为bg_color,不然icon的背景色就会随着主题的变化而变化
                            decoration: BoxDecoration(color: Colours.bg_color),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            )))),
              ),
            ),
            SizedBox(height: 30),
            MultiStateWidget(
                streamController: stateManager.streamController,
                contentBuilder: (context, data) {
                  return Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Now Playing', style: TextStyles.textBold16),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'All ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color),
                                    ),
                                    Text(data.totalResults.toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .textTheme
                                                .title
                                                .color)),
                                    Icon(Icons.chevron_right,
                                        color: Theme.of(context)
                                            .textTheme
                                            .title
                                            .color)
                                  ],
                                ),
                              )
                            ]),
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: data.results.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MovieItemVertical(
                                  data.results[index].posterPath,
                                  data.results[index].title,
                                  data.results[index].voteAvarege);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }
}
