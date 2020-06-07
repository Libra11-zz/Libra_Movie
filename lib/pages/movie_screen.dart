import 'package:flutter/material.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/widgets/now_playing_widget.dart';
import 'package:libra_movie/widgets/popular_widget.dart';

class MovieScreen extends StatefulWidget {
  MovieScreen({Key key}) : super(key: key);
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

// AutomaticKeepAliveClientMixin 保持页面状态  防止页面切换重新刷新
class _MovieScreenState extends State<MovieScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('Movie')),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // 下拉刷新
          nowPlayinglKey.currentState.loadData();
          popularKey.currentState.loadData();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              NowPlaying(key: nowPlayinglKey),
              Popular(key: popularKey)
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
