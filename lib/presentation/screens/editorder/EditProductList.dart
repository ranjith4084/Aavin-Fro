import 'dart:developer';

import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:aavinposfro/presentation/screens/home/indent/product_card.dart';
import 'package:flutter/material.dart';

import 'EditProductCard.dart';

class EditProductsList extends StatelessWidget {
  final List<Product> products;
  final Stock stock;
  final IndentOrder indentOrder;
  final Cart cart;

  EditProductsList(this.products, this.stock, this.cart,this.indentOrder, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(cart.items.toString());
    return this.products!=null&&this.products.length > 0
        ? ListView.separated(
        key: new PageStorageKey("products"),
        itemBuilder: (context, index) {
          var product = this.products[index];
          product.selected_quantity=0;
          return EditProductCard(
            product, cartQuantity: cart.items.containsKey(product) ? cart.items[product] : 0,
            stockQuantity: stock.items.containsKey(product) ? stock.items[product] : 0,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            color: Colors.grey,
          );
        },
        padding: EdgeInsets.only(bottom: 64),
        itemCount: this.products.length)
        : Center(child: Text("No items found."));
  }
}
