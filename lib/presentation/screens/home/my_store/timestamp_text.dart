import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeStampText extends StatelessWidget {
  final DateTime timeStamp;

  const TimeStampText({Key key, this.timeStamp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.green),
      child: Text(
        "Last Updated ${timeago.format(timeStamp)}",
        style:
            Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
