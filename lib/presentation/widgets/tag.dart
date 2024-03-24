import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Tag extends StatelessWidget {
  final Widget label;
  final Widget child;
  final Color color;

  const Tag({Key key, this.label, this.child, Color color})
      : this.color = color ?? Colors.grey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: this.color),
          borderRadius: BorderRadius.circular(4)),
      height: 20,
      child: Row(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          color: this.color,
          child: this.label,
        ),
        if (this.child != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: this.child,
          )
      ]),
    );
  }
}
