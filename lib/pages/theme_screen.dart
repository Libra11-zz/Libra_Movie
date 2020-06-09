import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/provider/theme_provider.dart';
import 'package:libra_movie/utils/theme_util.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  var _list = ['跟随系统', '开启', '关闭'];
  String language = SpUtil.getString(Constant.language);
  @override
  Widget build(BuildContext context) {
    String theme = SpUtil.getString(Constant.theme);
    String themeModeString = _list[2];
    switch (theme) {
      case 'Dark':
        themeModeString = _list[1];
        break;
      case 'Light':
        themeModeString = _list[2];
        break;
      default:
        themeModeString = _list[0];
        break;
    }
    return Scaffold(
      body:ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemExtent: 50.0, //强制高度为50.0
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          ThemeMode themeMode = index == 0
                              ? ThemeMode.system
                              : (index == 1 ? ThemeMode.dark : ThemeMode.light);
                          setState(() {
                            themeModeString = _list[index];
                          });
                          Provider.of<ThemeProvider>(context, listen: false)
                              .setTheme(themeMode);
                          // 更新status bar颜色
                          ThemeUtils.setStatusBar(context);
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
                                  opacity:
                                      themeModeString == _list[index] ? 1 : 0,
                                  child: Icon(Icons.done,
                                      color: Colors.orangeAccent))
                            ],
                          ),
                        ));
                  })
    );
  }
}