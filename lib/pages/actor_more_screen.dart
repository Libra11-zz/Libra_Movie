import 'package:flutter/material.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/widgets/actor_more_widget.dart';

class ActorMoreScreen extends StatefulWidget {
  @override
  _ActorMoreScreenState createState() => _ActorMoreScreenState();
}

class _ActorMoreScreenState extends State<ActorMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate('Actor')),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ActorMoreWidget(),
        ));
  }
}
