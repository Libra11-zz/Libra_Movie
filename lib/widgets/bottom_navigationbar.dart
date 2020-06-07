import 'package:flutter/material.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/pages/category_screen.dart';
import 'package:libra_movie/pages/movie_screen.dart';
import 'package:libra_movie/pages/other_screen.dart';
import 'package:libra_movie/pages/setting_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  List<Widget> pages = List<Widget>();
  int _currentIndex = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentIndex, keepPage: true);
    pages
      ..add(MovieScreen())
      ..add(CategoryScreen())
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
                  Icons.home,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('Home'),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('Category'),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('Search'),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('Settings'),
                )),
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
        ),
        body: PageView(
          controller: _pageController,
          children: this.pages,
        ));
  }
}
