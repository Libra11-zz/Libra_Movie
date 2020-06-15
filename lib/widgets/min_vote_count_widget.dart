import 'package:flutter/material.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/res/TextStyle.dart';

class MinVoteCountWidget extends StatefulWidget {
  final Function callBack;
  MinVoteCountWidget({Key key, this.callBack}) : super(key: key);
  @override
  _MinVoteCountWidgetState createState() => _MinVoteCountWidgetState();
}

class _MinVoteCountWidgetState extends State<MinVoteCountWidget> {
  double minVoteCount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(AppLocalizations.of(context).translate('MinimumUserVotes'),
            style: TextStyles.textBold16),
        Expanded(
          child: Slider(
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.orangeAccent.withAlpha(125),
            value: minVoteCount,
            min: 0,
            max: 500,
            divisions: 5,
            label: minVoteCount.toString(),
            onChanged: (val) {
              setState(() {
                minVoteCount = val;
              });
              widget.callBack(minVoteCount);
            },
          ),
        )
      ],
    );
  }
}
