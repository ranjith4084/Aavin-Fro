import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/presentation/widgets/order/cart_items_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewOrderContainer extends StatelessWidget {
  final Order order;

  const ReviewOrderContainer(this.order, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Order Summary",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 16,
          ),
          CartItemsList(
            items: this.order.cart.items,
          ),
          SizedBox(
            height: 8,
          ),
          OrderTotalContainer(this.order)
        ],
      ),
    );
  }
}
