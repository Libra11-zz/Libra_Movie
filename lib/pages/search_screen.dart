import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/api/movie_api.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/models/genre_model.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/pages/input_search_screen.dart';
import 'package:libra_movie/pages/movie_detail_screen.dart';
import 'package:libra_movie/res/TextStyle.dart';
import 'package:libra_movie/utils/net_state.dart';
import 'package:libra_movie/utils/state_manager.dart';
import 'package:libra_movie/widgets/choice_chip_wdiget.dart';
import 'package:libra_movie/widgets/error_widget.dart';
import 'package:libra_movie/widgets/loading_widget.dart';
import 'package:libra_movie/widgets/min_vote_count_widget.dart';
import 'package:libra_movie/widgets/movie_more_item.dart';
import 'package:libra_movie/widgets/runtime_widget.dart';
import 'package:libra_movie/widgets/vote_average_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  bool isLoading = false;
  bool error = false;
  StateManager stateManager;
  StateManager stateManager2;
  MovieModel response;
  GenreModel response2;
  ScrollController scrollController;
  MovieApi movieApi;
  int page = 1;
  int currentId = 28;
  double minVoteCount = 0;
  double minVoteAverage = 0;
  double maxVoteAverage = 10;
  double minRuntime = 0;
  double maxRuntime = 360;
  String sortBy = 'popularity.desc';
  String firstDate = DateUtil.formatDate(DateTime(DateTime.now().year - 5),
      format: "yyyy-MM-dd");
  String lastDate = DateUtil.formatDate(DateTime.now(), format: "yyyy-MM-dd");
  List<String> sorts = [
    "popularity.desc",
    "popularity.asc",
    "primary_release_date.desc",
    "primary_release_date.asc",
    "vote_average.desc",
    "vote_average.asc",
    "vote_count.desc",
    "vote_count.asc",
  ];
  @override
  void initState() {
    super.initState();
    stateManager = StateManager();
    stateManager2 = StateManager();
    scrollController = ScrollController();
    movieApi = MovieApi();
    _controller.text = firstDate.toString();
    _controller2.text = lastDate.toString();

    loadData();
    _loadGenre();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // 加载更多
        setState(() {
          isLoading = true;
          error = false;
        });
        movieApi
            .getFilterMovie(
                page: page + 1,
                sortBy: sortBy,
                releaseDateGte: firstDate,
                releaseDateLte: lastDate,
                voteAverageGte: minVoteAverage,
                voteAverageLte: maxVoteAverage,
                runtimeGte: minRuntime.toInt(),
                runtimeLte: maxRuntime.toInt(),
                genres: currentId.toString(),
                voteCount: minVoteCount.toInt())
            .then((val) {
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

  Future<MovieModel> _loadData() async {
    response = await movieApi.getFilterMovie(
        sortBy: sortBy,
        releaseDateGte: firstDate,
        releaseDateLte: lastDate,
        voteAverageGte: minVoteAverage,
        voteAverageLte: maxVoteAverage,
        runtimeGte: minRuntime.toInt(),
        runtimeLte: maxRuntime.toInt(),
        genres: currentId.toString(),
        voteCount: minVoteCount.toInt());
    return response;
  }

  Future<GenreModel> _loadGenre() async {
    response2 = await movieApi.getGenre();
    return response2;
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

  _onFilterButtonPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
          child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: bottomSheet(),
      )),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 0, style: BorderStyle.solid)),
    ).whenComplete(() {
      stateManager2.dispose();
    });
  }

  Widget bottomSheet() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
      child: Column(children: <Widget>[
        choiceChipWidget(AppLocalizations.of(context).translate('Category'),
            response2.results),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Text(AppLocalizations.of(context).translate('DateTime'),
                style: TextStyles.textBold16),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 50,
                child: TextField(
                  controller: _controller,
                  onChanged: (val) {
                    setState(() {
                      firstDate = val;
                    });
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    isDense: true,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                    suffixIcon: IconButton(
                      onPressed: () => pickFirstDate(),
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                height: 50,
                child: TextField(
                  controller: _controller2,
                  onChanged: (val) {
                    setState(() {
                      lastDate = val;
                    });
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.green,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                    suffixIcon: IconButton(
                      onPressed: () => pickLastDate(),
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        MinVoteCountWidget(
          callBack: (val) {
            setState(() {
              minVoteCount = val;
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        VoteAverageWidget(callBack: (val) {
          setState(() {
            minVoteAverage = val.start;
            maxVoteAverage = val.end;
          });
        }),
        SizedBox(
          height: 10,
        ),
        RuntimeWidget(callBack: (val) {
          setState(() {
            minRuntime = val.start;
            maxRuntime = val.end;
          });
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            OutlineButton(
                borderSide: BorderSide(color: Colors.orangeAccent),
                onPressed: () {
                  loadData();
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context).translate('Sure'),
                )),
            SizedBox(
              width: 10,
            ),
            OutlineButton(
                borderSide: BorderSide(color: Colors.orangeAccent),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context).translate('Cancel'),
                )),
          ],
        ),
        SizedBox(
          height: 30,
        )
      ]),
    );
  }

  pickFirstDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateUtil.getDateTime(firstDate),
        firstDate: DateUtil.getDateTime("1960-01-01"),
        lastDate: DateTime.now());
    if (date != null) {
      setState(() {
        firstDate = DateUtil.formatDate(date, format: "yyyy-MM-dd");
      });
      _controller.text = firstDate;
    }
  }

  pickLastDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateUtil.getDateTime(lastDate),
        firstDate: DateUtil.getDateTime("1960-01-01"),
        lastDate: DateTime.now());
    if (date != null) {
      setState(() {
        lastDate = DateUtil.formatDate(date, format: "yyyy-MM-dd");
      });
      _controller2.text = lastDate;
    }
  }

  Widget choiceChipWidget(String name, List<Genre> list) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(name, style: TextStyles.textBold16),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: ChoiceChipWidget(
          list: list,
          callBack: (id) {
            setState(() {
              currentId = id;
            });
          },
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate('Search')),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InputSearchScreen()));
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('FindMovie'),
                      style: TextStyles.textBold16),
                  Row(
                    children: <Widget>[
                      Row(children: <Widget>[
                        DropdownButton(
                            value: sortBy,
                            items: sorts.map<DropdownMenuItem>((String m) {
                              return DropdownMenuItem<String>(
                                value: m,
                                child: Text(
                                  AppLocalizations.of(context).translate(m),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                sortBy = val;
                              });
                              loadData();
                            })
                      ]),
                      SizedBox(
                        width: 10,
                      ),
                      Row(children: <Widget>[
                        FlatButton.icon(
                            label: Text(AppLocalizations.of(context)
                                .translate('Filter')),
                            onPressed: () => _onFilterButtonPressed(),
                            icon: Icon(Icons.filter, size: 16)),
                      ]),
                    ],
                  )
                ],
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
                        result = contentWidget(
                            context, (snap.data as ContentState).t);
                      }
                    } else {
                      result = Container();
                    }
                    return result;
                  })
            ],
          ),
        ));
  }

  Widget contentWidget(context, data) {
    return Expanded(
      child: Column(children: <Widget>[
        Flexible(
          child: ListView.builder(
            controller: scrollController,
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
                child: MovieMoreItem(movie: data.results[index]),
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
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
