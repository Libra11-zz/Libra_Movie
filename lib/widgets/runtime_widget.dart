import 'package:flutter/material.dart';
import 'package:libra_movie/localization/app_localization.dart';
import 'package:libra_movie/res/TextStyle.dart';

class RuntimeWidget extends StatefulWidget {
  final Function callBack;
  RuntimeWidget({Key key, @required this.callBack}) : super(key: key);
  @override
  _RuntimeWidgetState createState() => _RuntimeWidgetState();
}

class _RuntimeWidgetState extends State<RuntimeWidget> {
  var selectedRange = RangeValues(0, 360);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(AppLocalizations.of(context).translate('RunTime'),
            style: TextStyles.textBold16),
        Expanded(
          child: RangeSlider(
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.orangeAccent.withAlpha(125),
            values: selectedRange,
            min: 0,
            max: 360,
            divisions: 24,
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
