import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:libra_movie/res/TextStyle.dart';

class MovieItemHorizontal extends StatelessWidget {
  final String src;
  final String title;
  final double rate;
  final String desc;
  MovieItemHorizontal(this.src, this.title, this.desc, this.rate);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: <Widget>[
        Container(
            width: 116,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              image: DecorationImage(
                  image: NetworkImage('https://image.tmdb.org/t/p/w500$src'),
                  fit: BoxFit.cover),
            )),
        Expanded(
          child: Container(
            height: 160,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textBold16),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      RatingBar(
                        onRatingUpdate: (_) {},
                        initialRating: rate / 2,
                        direction: Axis.horizontal,
                        unratedColor: Colors.white,
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
                      SizedBox(width: 5),
                      Text(rate.toString(), style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
