import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libra_movie/common/common.dart';

class ThemeUtils {
  static void setStatusBar(context) {
    String theme = SpUtil.getString(Constant.theme);
    // 获取系统主题颜色
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    var res;
    var sbBrightness;
    if (theme == 'Light') {
      res = Brightness.dark;
      sbBrightness = Brightness.light;
    } else if (theme == 'Dark') {
      res = Brightness.light;
      sbBrightness = Brightness.dark;
    } else if (theme == 'System' && isDark) {
      res = Brightness.light;
      sbBrightness = Brightness.dark;
    } else {
      res = Brightness.dark;
      sbBrightness = Brightness.light;
    }
    // 更改statusbar的背景色为透明色
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,
      systemNavigationBarIconBrightness: res,
      statusBarIconBrightness: res,
      statusBarBrightness: sbBrightness,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
