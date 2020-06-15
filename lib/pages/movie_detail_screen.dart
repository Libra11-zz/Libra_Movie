import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/models/result_model.dart';
import 'package:libra_movie/widgets/casts_widget.dart';
import 'package:libra_movie/widgets/movie_detail_widget.dart';
import 'package:libra_movie/widgets/movie_info_widget.dart';
import 'package:libra_movie/widgets/similar_movies_widget.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailScreen extends StatefulWidget {
  final Result movie;
  MovieDetailScreen({Key key, @required this.movie}) : super(key: key);
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (context) {
        return SliverFab(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    title: Text(widget.movie.title,
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    background: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/${widget.movie.backdropPath}"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.0),
                              ])),
                        ),
                      ],
                    )),
              ),
              SliverPadding(
                  padding: EdgeInsets.all(0.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(widget.movie.voteAvarege.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 5),
                              RatingBar(
                                onRatingUpdate: (_) {},
                                initialRating: widget.movie.voteAvarege / 2,
                                unratedColor: Colors.white,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                ignoreGestures: true,
                                itemSize: 15,
                                itemPadding: EdgeInsets.only(right: 4, top: 4),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Text(
                          AppLocalizations.of(context).translate('Overview'),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.movie.overview,
                          style: TextStyle(fontSize: 12.0, height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MovieInfo(
                        id: widget.movie.id,
                      ),
                      Casts(
                        id: widget.movie.id,
                      ),
                      SimilarMovies(id: widget.movie.id)
                    ]),
                  ))
            ],
            expandedHeight: 200.0,
            floatingPosition: FloatingPosition(right: 20),
            floatingWidget: MovieDetailWidget(movieId: widget.movie.id));
      },
    ));
  }
}
