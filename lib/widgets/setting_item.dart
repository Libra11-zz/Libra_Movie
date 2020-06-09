import 'package:flutter/material.dart';

class SettingItem extends StatefulWidget {
  final Icon icon;
  final String text;
  final String text2;
  Function callBack;

  SettingItem(
      {Key key,
      @required this.icon,
      @required this.text,
      @required this.text2,
      @required this.callBack})
      : super(key: key);
  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.callBack,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        widget.icon,
                        SizedBox(
                          width: 20,
                        ),
                        Text(widget.text)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(widget.text2),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }
}
