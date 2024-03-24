import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWithTag extends StatelessWidget {
  final Color backgoundColor;
  final TextStyle textStyle;
  final String text;
  static const Color defaultBackgroundColor = Colors.grey;
  static const Color defaultTextColor = Colors.white;
  static const TextStyle defaultTextStyle = const TextStyle(
      color: defaultTextColor, fontSize: 12, fontWeight: FontWeight.bold);

  const TextWithTag(
      {Key key,
      this.backgoundColor = defaultBackgroundColor,
      @required this.text,
      this.textStyle = defaultTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: new EdgeInsets.all(4),
      margin: new EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: BoxDecoration(
          color: this.backgoundColor,
          borderRadius: new BorderRadius.circular(4)),
      child: Text(
        this.text,
        style: this.textStyle,
      ),
    );
  }
}
