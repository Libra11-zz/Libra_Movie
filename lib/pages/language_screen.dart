import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/provider/language_provider.dart';
import 'package:libra_movie/widgets/restart_widget.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  var _list = ['跟随系统', '中文', '英文'];
  @override
  Widget build(BuildContext context) {
    String language = SpUtil.getString(Constant.language);
    String languageString = _list[1];
    switch (language) {
      case 'zh':
        languageString = _list[1];
        break;
      case 'en':
        languageString = _list[2];
        break;
      case 'System':
        languageString = _list[0];
        break;
    }
    return Scaffold(
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _list.length,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  String lan = language;
                  if (index == 0) {
                    lan = 'System';
                  } else if (index == 1) {
                    lan = 'zh';
                  } else if (index == 2) {
                    lan = 'en';
                  } else {
                    lan = "en";
                  }
                  Provider.of<LanguageProvider>(context, listen: false)
                      // 更新status bar颜色
                      .changeLanguage(Locale(lan));
                  RestartWidget.restartApp(context);
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_list[index]),
                      ),
                      Opacity(
                          opacity: languageString == _list[index] ? 1 : 0,
                          child: Icon(Icons.done, color: Colors.orangeAccent))
                    ],
                  ),
                ));
          }),
    );
  }
}
