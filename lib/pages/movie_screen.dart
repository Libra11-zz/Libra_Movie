import 'package:flutter/material.dart';
import 'package:libra_movie/widgets/now_playing_widget.dart';
import 'package:libra_movie/widgets/popular_widget.dart';

Color firstColor = Color(0xFFF47D15);
TextStyle dropDownMenuItemStyle =
    TextStyle(color: Colors.white, fontSize: 16.0);

class MovieScreen extends StatefulWidget {
  MovieScreen({Key key}) : super(key: key);
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: <Widget>[NowPlaying(), Popular()],
        ),
      ),
    );
  }
}
