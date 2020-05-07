import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  MovieScreen({Key key}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("movie screen"),
        ),
      ),
    );
  }
}
