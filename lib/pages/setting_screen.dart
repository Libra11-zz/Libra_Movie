import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/pages/theme_screen.dart';
import 'package:libra_movie/widgets/setting_item.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String languageStr = "";
  String themeStr = "";

  @override
  void initState() {
    super.initState();
    // initLanguage(context);
    // initTheme(context);
  }

  initLanguage(context) {
    String language = SpUtil.getString(Constant.language);
    switch (language) {
      case 'zh':
        languageStr = "简体中文";
        break;
      case 'en':
        languageStr = "English";
        break;
      default:
        languageStr = "1";
        break;
    }
  }

  initTheme(context) {
    String theme = SpUtil.getString(Constant.theme);
    switch (theme) {
      case 'Dark':
        themeStr = AppLocalizations.of(context).translate('Open');
        break;
      case 'Light':
        themeStr = AppLocalizations.of(context).translate('Close');
        break;
      default:
        themeStr = "1";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('Settings')),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            // SettingItem(
            //   icon: Icon(Icons.language),
            //   text: '语言',
            //   text2: languageStr == "1"
            //       ? AppLocalizations.of(context).translate('System')
            //       : languageStr,
            //   callBack: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => LanguageScreen()));
            //   },
            // ),
            SettingItem(
              icon: Icon(Icons.dashboard),
              text: '夜间模式',
              text2: themeStr == "1"
                  ? AppLocalizations.of(context).translate('System').toString()
                  : themeStr,
              callBack: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ThemeScreen()));
              },
            ),
            // SettingItem(
            //   icon: Icon(Icons.golf_course),
            //   text: '项目地址',
            //   text2: "",
            //   callBack: () {},
            // ),
            // SettingItem(
            //   icon: Icon(Icons.contact_phone),
            //   text: '联系我',
            //   text2: "",
            //   callBack: () {},
            // ),
            // SettingItem(
            //   icon: Icon(Icons.verified_user),
            //   text: '版本号',
            //   text2: "1.0.0",
            //   callBack: () {},
            // ),
          ],
        ));
  }
}
