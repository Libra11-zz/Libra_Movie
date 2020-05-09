import 'package:flutter/material.dart';
import 'package:libra_movie/widgets/restart_widget.dart';

class OtherScreen extends StatefulWidget {
  OtherScreen({Key key}) : super(key: key);

  @override
  _OtherScreenState createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FlatButton(
              onPressed: () {
                RestartWidget.restartApp(context);
              },
              child: Text('重启')),
        ),
      ),
    );
  }
}
