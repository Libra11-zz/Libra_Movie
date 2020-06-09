import 'package:flutter/material.dart';
import 'package:libra_movie/widgets/fade_animations.dart';
import 'package:libra_movie/widgets/person_detail_widget.dart';
import 'package:libra_movie/widgets/person_video_widget.dart';

class ActorDetail<T> extends StatefulWidget {
  final T actor;
  ActorDetail({Key key, @required this.actor}) : super(key: key);
  @override
  _ActorDetailState createState() => _ActorDetailState();
}

class _ActorDetailState extends State<ActorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(
                  widget.actor.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                expandedHeight: 450,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500/${widget.actor.profileImg}"),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.black.withOpacity(0.0),
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(
                                1,
                                Text(
                                  widget.actor.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  PersonVideo(id: widget.actor.id),
                  PersonDetailWidget(id: widget.actor.id),
                ]),
              )
            ],
          ),
        ],
      ),
    );
  }
}
