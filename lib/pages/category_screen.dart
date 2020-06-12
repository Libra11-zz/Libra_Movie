import 'package:flutter/material.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/pages/input_search_screen.dart';
import 'package:libra_movie/widgets/genre_widget.dart';
import 'package:libra_movie/widgets/top_rated_widget.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate('Category')),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputSearchScreen()));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          genresKey.currentState.loadData();
          topRatedKey.currentState.loadData();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              GenresScreen(key: genresKey),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TopRated(key: topRatedKey),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
