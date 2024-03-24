import 'package:flutter/material.dart';

class SettlementViewStatement extends StatefulWidget {
  var cash;
  var excessvalue;
  DateTime dateTime;
  SettlementViewStatement({this.dateTime,this.cash,this.excessvalue});
  @override
  State<SettlementViewStatement> createState() =>
      _SettlementViewStatementState();
}

class _SettlementViewStatementState extends State<SettlementViewStatement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Settlement"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Date:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(10.0),
                decoration: myBoxDecoration(),
                //             <--- BoxDecoration here
                child: Text(
                  "excessvalue",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'cash:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(10.0),
                decoration: myBoxDecoration(),
                //             <--- BoxDecoration here
                child: Text(
                  "excessvalue",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Excess:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(10.0),
                decoration: myBoxDecoration(),
                //             <--- BoxDecoration here
                child: Text(
                  "excessvalue",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }
}
