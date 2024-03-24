import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/product.dart';
import 'item_card.dart';

class StockList extends StatelessWidget {
  final Map<Product, int> stock;
  final bool isEditable;

  const StockList(this.stock, {Key key, bool isEditable})
      : this.isEditable = isEditable ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.stock.length,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.only(bottom: 96),
      itemBuilder: (context, index) => ItemCard(
        stock.keys.toList()[index],
        stockQuantity: stock[stock.keys.toList()[index]],
        isEditable: this.isEditable,
        draftQuantity: 3,
      ),
    );
  }
}
