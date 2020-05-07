import 'package:flutter/material.dart';
import 'package:libra_movie/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Libra_Movie',
      initialRoute: '/splash',
      routes: routes,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
