import 'package:flutter/material.dart';
import 'package:libra_movie/pages/movie_detail_screen.dart';
import 'package:libra_movie/pages/splash_screen.dart';
import 'package:libra_movie/widgets/bottom_navigationbar.dart';

final routes = {
  "/splash": (context) => SplashScreen(),
  "/main": (context) => BottomNavigationWidget(),
  "/movieDetail": (context, movie) => MovieDetailScreen(movie: movie),
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
