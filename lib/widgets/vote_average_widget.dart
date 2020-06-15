import 'package:flutter/material.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/res/TextStyle.dart';

class VoteAverageWidget extends StatefulWidget {
  final Function callBack;
  VoteAverageWidget({Key key, @required this.callBack}) : super(key: key);
  @override
  _VoteAverageWidgetState createState() => _VoteAverageWidgetState();
}

class _VoteAverageWidgetState extends State<VoteAverageWidget> {
  var selectedRange = RangeValues(0, 10);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(AppLocalizations.of(context).translate('UserScore'),
            style: TextStyles.textBold16),
        Expanded(
          child: RangeSlider(
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.orangeAccent.withAlpha(125),
            values: selectedRange,
            min: 0,
            max: 10,
            divisions: 10,
            labels:
                RangeLabels("${selectedRange.start}", "${selectedRange.end}"),
            onChanged: (RangeValues val) {
              setState(() {
                selectedRange = val;
              });
              widget.callBack(selectedRange);
            },
          ),
        )
      ],
    );
  }
}
