import 'package:flutter/material.dart';

class ChoiceChipWidget extends StatefulWidget {
  final List list;

  final Function callBack;
  ChoiceChipWidget({Key key, @required this.list, this.callBack})
      : super(key: key);
  @override
  _ChoiceChipWidgetState createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  int currentId = 28;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: -10,
      children: List<Widget>.generate(
        widget.list.length,
        (int index) {
          return ChoiceChip(
            label: Text(widget.list[index].name),
            selected: widget.list[index].id == currentId,
            onSelected: (bool selected) {
              if (selected) {
                setState(() {
                  currentId = widget.list[index].id;
                });
              } else {
                setState(() {
                  currentId = 0;
                });
              }
              widget.callBack(currentId);
            },
          );
        },
      ).toList(),
    );
  }
}
