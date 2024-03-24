import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/presentation/widgets/text_with_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class OrderDetailList extends StatelessWidget {
  final List<Product> items;

  const OrderDetailList({this.items,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var products = this.items.keys.toList();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[400]))),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 6,
                  child: Text(
                    "Product",
                    style: Theme.of(context).textTheme.subtitle2,
                  )),
              Expanded(
                  flex: 3,
                  child: Center(
                      child: Text("Quantity",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle2))),
              Expanded(
                  flex: 2,
                  child: Center(
                      child: Text("Price",
                          style: Theme.of(context).textTheme.subtitle2))),
            ],
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: this.items.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
            //  debugPrint("currentproducts"+products[index].toString()+this.items[products[index]].toString());
              return ProductListRow(
                product: this.items[index],
                quantity: this.items[index].selected_quantity,
                key: Key(index.toString()),
              );
            }),
      ],
    );
  }
}

class ProductListRow extends StatelessWidget {
  final Product product;
  final int quantity;



  const ProductListRow({Key key, this.product, this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextWithTag(
                      text: this.product.id,

                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      this.product.name,
                    ),
                  ),),
                ],
              )),
          Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                this.quantity.toString(),
              ))),
          Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("₹ ${(this.product.price * this.quantity).toStringAsFixed(2)}")))
        ],
      ),
    );
  }
}

class OrderHistoryTotalContainer extends StatelessWidget {
  final PointOfSaleOrder order;

  const OrderHistoryTotalContainer(this.order);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Sub Total",
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("₹ ${this.order.sub_total.toString()}")),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "CGST",
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("₹ ${this.order.cgst}")),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Text("SGST"),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("₹ ${this.order.sgst}")),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Total",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "₹ ${this.order.total..toString()}",
                    style: Theme.of(context).textTheme.headline5,
                  )),
            )
          ],
        )
      ],
    );
  }
}

