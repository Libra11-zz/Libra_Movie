import 'dart:async';

import 'package:flutter/material.dart';
import 'package:libra_movie/utils/media_query.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  int _countDownTime = 3;

  @override
  void initState() {
    super.initState();
    startCountdownTimer(context);
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/splash.jpeg'),
              fit: BoxFit.fill,
            ),
            Positioned(
                top: ScreenUtils.getInstance().appBarHeight,
                right: 12,
                child: Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          print("object");
                        },
                        child: Text("$_countDownTime | 跳过"),
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  void startCountdownTimer(context) {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) {
      setState(() {
        if (_countDownTime < 1) {
          goToMovieScreen(context);
        } else {
          _countDownTime = _countDownTime - 1;
        }
      });
    };
    _timer = Timer.periodic(oneSec, callback);
  }

  void goToMovieScreen(context) {
    _timer.cancel();
    Navigator.pushNamed(context, '/main');
  }
}
