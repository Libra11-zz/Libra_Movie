import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/res/Colors.dart';
import 'package:libra_movie/res/TextStyle.dart';

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
      primaryColorDark: Colours.dark_bg_color,
      primaryColor: Colours.bg_color,
      accentColor: isDarkMode ? Colors.white : Colors.black,
      primaryColorBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      // 页面背景色
      scaffoldBackgroundColor:
          isDarkMode ? Colours.dark_bg_color : Colours.bg_color,
      textTheme: TextTheme(
        // TextField输入文字颜色
        subhead: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // Text文字样式
        body1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        title: isDarkMode ? TextStyles.textDark : TextStyles.text,
        subtitle:
            isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      ),
      canvasColor: isDarkMode ? Colours.dark_bg_color : Colours.bg_color,
      inputDecorationTheme: InputDecorationTheme(
          hintStyle:
              isDarkMode ? TextStyles.textHint16 : TextStyles.textDarkGray14,
          fillColor: Colours.bg_color),
    );
  }
}
