import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/pages/contact_me_screen.dart';
import 'package:libra_movie/pages/github_screen.dart';
import 'package:libra_movie/pages/language_screen.dart';
import 'package:libra_movie/pages/theme_screen.dart';
import 'package:libra_movie/widgets/setting_item.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String languageStr = "";

  @override
  void initState() {
    super.initState();
    initLanguage();
  }

  initLanguage() {
    String language = SpUtil.getString(Constant.language);
    print(language);
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
            SettingItem(
              icon: Icon(Icons.language),
              text: AppLocalizations.of(context).translate('Language'),
              text2: languageStr == "1"
                  ? AppLocalizations.of(context).translate('System')
                  : languageStr,
              callBack: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LanguageScreen()));
              },
            ),
            SettingItem(
              icon: Icon(Icons.dashboard),
              text: AppLocalizations.of(context).translate('DarkMode'),
              text2: "",
              callBack: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ThemeScreen()));
              },
            ),
            SettingItem(
              icon: Icon(Icons.golf_course),
              text: AppLocalizations.of(context).translate('ProjectAddr'),
              text2: "",
              callBack: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GithubScreen()));
              },
            ),
            SettingItem(
              icon: Icon(Icons.contact_phone),
              text: AppLocalizations.of(context).translate('Contact'),
              text2: "",
              callBack: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactMeScreen()));
              },
            ),
            SettingItem(
              icon: Icon(Icons.verified_user),
              text: AppLocalizations.of(context).translate('Version'),
              text2: "1.0.1",
              callBack: () {},
            ),
          ],
        ));
  }
}
