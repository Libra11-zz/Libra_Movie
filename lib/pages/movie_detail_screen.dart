import 'package:flutter/material.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/widgets/movie_detail_widget.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailScreen extends StatefulWidget {
  final Result movie;
  MovieDetailScreen({Key key, @required this.movie}) : super(key: key);
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final Result movie;
  _MovieDetailScreenState(this.movie);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (context) {
        return SliverFab(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.blueAccent,
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    title: Text(movie.title),
                    background: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/${movie.backdropPath}"))),
                          child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.0),
                              ]))),
                        )
                      ],
                    )),
              )
            ],
            expandedHeight: 200.0,
            floatingPosition: FloatingPosition(right: 20),
            floatingWidget: MovieDetailWidget(movieId: movie.id));
      },
    ));
  }
}
