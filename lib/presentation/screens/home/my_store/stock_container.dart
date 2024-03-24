import 'package:aavinposfro/models/stock.dart';
import 'package:aavinposfro/presentation/screens/home/my_store/timestamp_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'stock_list.dart';

class StockContainer extends StatelessWidget {
  final Stock stock;

  const StockContainer(this.stock, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.stock.items.length > 0) {
      return Column(
        children: <Widget>[
          Material(elevation: 3,child: TimeStampText(timeStamp: this.stock.updatedAt)),
          Expanded(child: StockList(this.stock.items))
        ],
      );
    } else {
      return Center(child: Text("No items found."));
    }
  }
}
