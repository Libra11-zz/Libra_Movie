import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/provider/theme_provider.dart';
import 'package:libra_movie/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(builder: (_, provider, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Libra_Movie',
          initialRoute: '/splash',
          routes: routes,
          theme: provider.getTheme(),
          darkTheme: provider.getTheme(isDarkMode: true),
          themeMode: provider.getThemeMode(),
          onGenerateRoute: onGenerateRoute,
        );
      }),
    );
  }
}
