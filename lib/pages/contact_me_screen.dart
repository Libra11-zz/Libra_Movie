import 'dart:async';

import 'package:flutter/material.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactMeScreen extends StatefulWidget {
  @override
  _ContactMeScreenState createState() => _ContactMeScreenState();
}

class _ContactMeScreenState extends State<ContactMeScreen> {
  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate('Contact')),
        ),
        body: IndexedStack(
          index: _stackToView,
          children: <Widget>[
            WebView(
              initialUrl: "https://mp.weixin.qq.com/s/tJotnns7RQTo85-XMv3oow",
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: _handleLoad,
              onWebViewCreated: (WebViewController controller) {
                _controller.complete(controller);
              },
            ),
            Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ));
  }
}
