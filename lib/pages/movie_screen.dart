import 'package:flutter/material.dart';
import 'package:libra_movie/models/movie_model.dart';
import 'package:libra_movie/provider/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("movie"),
    );
  }
}
