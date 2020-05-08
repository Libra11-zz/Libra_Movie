import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/res/Colors.dart';

class ThemeProvider extends ChangeNotifier {
  static const Map<ThemeMode, String> themes = {
    ThemeMode.dark: 'Dark',
    ThemeMode.light: 'Light',
    ThemeMode.system: 'System'
  };

  void syncTheme() {
    String theme = SpUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != themes[ThemeMode.system]) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(Constant.theme, themes[themeMode]);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    String theme = SpUtil.getString(Constant.theme);
    switch (theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  getTheme({bool isDarkMode: false}) {
    return ThemeData(
      // 页面背景色
      scaffoldBackgroundColor:
          isDarkMode ? Colours.dark_bg_color : Colours.bg_color,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? Colours.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
