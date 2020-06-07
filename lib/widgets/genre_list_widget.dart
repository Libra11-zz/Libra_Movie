import 'package:flutter/material.dart';
import 'package:libra_movie/models/genre_model.dart';
import 'package:libra_movie/res/Colors.dart';
import 'package:libra_movie/widgets/genre_movie_widget.dart';

class GenresList extends StatefulWidget {
  final GenreModel genres;
  GenresList({Key key, @required this.genres}) : super(key: key);
  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  final GenreModel genres;
  _GenresListState(this.genres);
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.results.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // to do
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 307.0,
        child: DefaultTabController(
          length: genres.results.length,
          child: Scaffold(
            // backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  isScrollable: true,
                  tabs: genres.results.map((Genre genre) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: new Text(genre.name,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )));
                  }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: genres.results.map((Genre genre) {
                return GenreMovie(
                  genreId: genre.id,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
