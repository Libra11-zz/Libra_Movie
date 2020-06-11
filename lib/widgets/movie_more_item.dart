import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:libra_movie/models/result_model.dart';
import 'package:libra_movie/res/TextStyle.dart';

class MovieMoreItem extends StatefulWidget {
  final Result movie;
  MovieMoreItem({Key key, @required this.movie}) : super(key: key);
  @override
  _MovieMoreItemState createState() => _MovieMoreItemState(movie);
}

class _MovieMoreItemState extends State<MovieMoreItem> {
  final Result movie;
  _MovieMoreItemState(this.movie);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                        fit: BoxFit.cover),
                  )),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
                        fit: BoxFit.cover),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Row(children: <Widget>[
              Text(movie.title, style: TextStyles.textBold16),
              SizedBox(
                width: 10,
              ),
              Text("(${movie.releaseDate})", style: TextStyles.textBold14),
            ])),
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            RatingBar(
              onRatingUpdate: (_) {},
              initialRating: movie.voteAvarege / 2,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ignoreGestures: true,
              itemSize: 12,
              itemPadding: EdgeInsets.only(right: 4, top: 4),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            SizedBox(width: 5),
            Text(movie.voteAvarege.toString(), style: TextStyle(fontSize: 12)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              movie.overview,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.textSize14,
              maxLines: 4,
            )),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}
