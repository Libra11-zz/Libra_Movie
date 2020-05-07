import 'package:flutter/material.dart';
import 'package:libra_movie/pages/movie_screen.dart';
import 'package:libra_movie/pages/other_screen.dart';
import 'package:libra_movie/pages/setting_screen.dart';
import 'package:libra_movie/pages/tv_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  List<Widget> pages = List<Widget>();
  final _bottomNavigationColor = Colors.blue;
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
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.movie_filter,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  '电影',
                  style: TextStyle(color: _bottomNavigationColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.live_tv,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  '电视剧',
                  style: TextStyle(color: _bottomNavigationColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.devices_other,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  '其他',
                  style: TextStyle(color: _bottomNavigationColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  '设置',
                  style: TextStyle(color: _bottomNavigationColor),
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
