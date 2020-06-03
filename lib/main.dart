import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:libra_movie/common/common.dart';
import 'package:libra_movie/provider/language_provider.dart';
import 'package:libra_movie/provider/theme_provider.dart';
import 'package:libra_movie/routes/routes.dart';
import 'package:libra_movie/utils/theme_util.dart';
import 'package:libra_movie/widgets/restart_widget.dart';
import 'package:provider/provider.dart';

import 'localization/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider())
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
          builder: (_, provider, language, __) {
        return MaterialApp(
          locale: language.appLocale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'), // English
            const Locale.fromSubtags(
                languageCode: 'zh', countryCode: 'CN', scriptCode: 'Hans'),
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            Locale result;
            String lan = SpUtil.getString(Constant.language);
            switch (lan) {
              case 'zh':
                result = Locale('zh');
                break;
              case 'en':
                result = Locale('en');
                break;
              case 'System':
                result = locale;
                break;
            }
            return result;
          },
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
