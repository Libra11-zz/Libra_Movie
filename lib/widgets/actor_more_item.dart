import 'package:flutter/material.dart';
import 'package:libra_movie/models/person.dart';
import 'package:libra_movie/res/TextStyle.dart';

class ActorMoreItem extends StatefulWidget {
  final Person actor;
  ActorMoreItem({Key key, @required this.actor}) : super(key: key);
  @override
  _ActorMoreItemState createState() => _ActorMoreItemState(actor);
}

class _ActorMoreItemState extends State<ActorMoreItem> {
  final Person actor;
  _ActorMoreItemState(this.actor);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${actor.profileImg}'),
                      fit: BoxFit.cover),
                )),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(actor.name, style: TextStyles.textBold16),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(actor.popularity.toString(),
                        style: TextStyle(fontSize: 12)),
                    SizedBox(width: 5),
                    Text(actor.known.toString(),
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
