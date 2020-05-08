import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var _list = ['跟随系统', '开启', '关闭'];
  @override
  Widget build(BuildContext context) {
    String theme = SpUtil.getString(Constant.theme);
    String themeModeString;
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
      body: Container(
          child: ListView.builder(
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
                              opacity: themeModeString == _list[index] ? 1 : 0,
                              child:
                                  Icon(Icons.done, color: Colors.orangeAccent))
                        ],
                      ),
                    ));
              })),
    );
  }
}
