import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:libra_movie/common/common.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _appLocale = Locale('en');
  Locale get appLocale => _appLocale ?? Locale('en');
  fetchLocale() async {
    if (SpUtil.getString(Constant.language) == '') {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(SpUtil.getString(Constant.language));
    return Null;
  }

  void changeLanguage(Locale type) async {
    await fetchLocale();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("zh")) {
      _appLocale = Locale("zh");
      await SpUtil.putString(Constant.language, 'zh');
    } else if (type == Locale("en")) {
      _appLocale = Locale("en");
      await SpUtil.putString(Constant.language, 'en');
    } else {
      String myLocale = ui.window.locale.languageCode;
      _appLocale = Locale(myLocale);
      await SpUtil.putString(Constant.language, 'System');
    }
    notifyListeners();
  }
}
