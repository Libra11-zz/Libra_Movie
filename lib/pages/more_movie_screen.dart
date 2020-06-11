import 'package:flutter/material.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/widgets/movie_more_widget.dart';

class MoreMovieScreen extends StatefulWidget {
  final String url;
  MoreMovieScreen({Key key, @required this.url}) : super(key: key);
  @override
  _MoreMovieScreenState createState() => _MoreMovieScreenState(url);
}

class _MoreMovieScreenState extends State<MoreMovieScreen> {
  final String url;
  _MoreMovieScreenState(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate('Movie')),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: MovieMoreWidget(
            url: url,
          ),
        ));
  }
}
