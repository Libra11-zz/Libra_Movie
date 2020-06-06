import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:libra_movie/res/Colors.dart';
import 'package:libra_movie/res/TextStyle.dart';
import 'package:libra_movie/widgets/now_playing_widget.dart';
import 'package:libra_movie/widgets/popular_widget.dart';

Color firstColor = Color(0xFFF47D15);
TextStyle dropDownMenuItemStyle =
    TextStyle(color: Colors.white, fontSize: 16.0);

class MovieScreen extends StatefulWidget {
  MovieScreen({Key key}) : super(key: key);
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: ScreenUtil.getStatusBarH(context) + 10, left: 10, right: 10),
      child: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 80,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Movie',
                    textAlign: TextAlign.left, style: TextStyles.textBold24),
              )),
          Material(
            elevation: 2.0,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3), bottomLeft: Radius.circular(3)),
            child: TextField(
              controller: TextEditingController(text: ''),
              cursorColor: firstColor,
              decoration: InputDecoration(
                  hintText: 'search movies......',
                  filled: true,
                  border: InputBorder.none,
                  suffixIcon: Material(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3)),
                      child: Container(
                          // Material 默认使用的Canvas的颜色 这里将颜色改为bg_color,不然icon的背景色就会随着主题的变化而变化
                          decoration: BoxDecoration(color: Colours.bg_color),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          )))),
            ),
          ),
          SizedBox(height: 30),
          NowPlaying(),
          Popular()
        ],
      ),
    );
  }
}
