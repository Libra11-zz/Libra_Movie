import 'package:flutter/material.dart';
import 'package:libra_movie/pages/movie_screen.dart';
import 'package:libra_movie/pages/other_screen.dart';
import 'package:libra_movie/pages/setting_screen.dart';
import 'package:libra_movie/pages/tv_screen.dart';
import 'package:libra_movie/utils/theme_util.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  List<Widget> pages = List<Widget>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pages
      ..add(MovieScreen())
      ..add(TVScreen())
      ..add(OtherScreen())
      ..add(SettingScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.orangeAccent,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.movie_filter,
                ),
                title: Text(
                  '电影',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.live_tv,
                ),
                title: Text(
                  '电视剧',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.devices_other,
                ),
                title: Text(
                  '其他',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                title: Text(
                  '设置',
                )),
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: pages[_currentIndex]);
  }
}
