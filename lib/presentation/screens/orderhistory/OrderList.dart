import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:aavinposfro/presentation/screens/home/indent/product_card.dart';
import 'package:aavinposfro/presentation/screens/orderhistory/OrderViewCard.dart';
import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  final List<PointOfSaleOrder> indentOrder;

  OrderList(this.indentOrder, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.indentOrder!=null&&this.indentOrder.length > 0
        ? ListView.separated(
        key: new PageStorageKey("products"),
        itemBuilder: (context, index) {
          var order = this.indentOrder[index];
          return OrdersViewCard(
            order_title: order.orderID,
            order_total_price: order.total,
            order_created_date: order.Created_At.toUtc().millisecondsSinceEpoch,
            indentOrder: order,

          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            color: Colors.grey,
          );
        },
        padding: EdgeInsets.only(bottom: 64),
        itemCount: this.indentOrder.length)
        : Center(child: Text("No items found."));
  }
}
