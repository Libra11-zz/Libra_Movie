import 'package:flutter/material.dart';

class FilterMovieScreen extends StatefulWidget {
  @override
  _FilterMovieScreenState createState() => _FilterMovieScreenState();
}

class _FilterMovieScreenState extends State<FilterMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Filter"),
      ),
    );
  }
}
