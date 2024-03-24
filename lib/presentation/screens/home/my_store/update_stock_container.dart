import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/presentation/screens/home/my_store/stock_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpdateStockContainer extends StatelessWidget {
  final Map<Product, int> items;

  const UpdateStockContainer(
    this.items, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.store_mall_directory,
                  color: Colors.grey,
                  size: Theme.of(context).textTheme.subtitle1.fontSize,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "IN-STOCK ITEMS".toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ),
        StockList(this.items, isEditable: true)
      ],
    );
  }
}
