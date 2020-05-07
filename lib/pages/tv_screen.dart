import 'package:flutter/material.dart';

class TVScreen extends StatefulWidget {
  TVScreen({Key key}) : super(key: key);

  @override
  _TVScreenState createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("tv screen"),
        ),
      ),
    );
  }
}
