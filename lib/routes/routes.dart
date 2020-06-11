import 'package:flutter/material.dart';
import 'package:libra_movie/pages/movie_detail_screen.dart';
import 'package:libra_movie/pages/splash_screen.dart';
import 'package:libra_movie/widgets/bottom_navigationbar.dart';

final routes = {
  "/splash": (context) => SplashScreen(),
  "/main": (context) => BottomNavigationWidget(),
  "/movieDetail": (context, {arguments}) => MovieDetailScreen(movie: arguments),
};

RouteFactory onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  Route route;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return route;
};
