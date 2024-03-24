import 'package:flutter/material.dart';

class previousDispatchListViewScreen extends StatefulWidget {
  String order_ShipmentID;
  Map order_Product;

  previousDispatchListViewScreen({
    this.order_ShipmentID,
    this.order_Product,
  });

  @override
  State<previousDispatchListViewScreen> createState() =>
      _previousDispatchListViewScreenState();
}

class _previousDispatchListViewScreenState
    extends State<previousDispatchListViewScreen> {
  @override
  onPress() {
    Navigator.of(context).pop();
    // _vm.back();
  }

  List id = [];
  List qty = [];

  Widget build(BuildContext context) {
    // //print(widget.order_ShipmentID);
    // //print(widget.order_Product);
    widget.order_Product.forEach((key, value) {
      // //print('key is $key');

      // //print('value is $value ');
      id.add(key);
      qty.add(value);
    });
    // //print("+++++++++++++++++++++");
    // //print(id);
    // //print(qty);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Details"),
          leading: new IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: onPress,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      "Order Details",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Shipment ID : ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.order_ShipmentID,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 2, color: Colors.black),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Product ID",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Quantity",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 2, color: Colors.black),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            children: id
                                .map((i) => Column(
                                      children: [
                                        Text(i.toString()),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ))
                                .toList()),
                        Column(
                            children: id
                                .map((i) => Column(
                              children: [
                                Text("-"),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ))
                                .toList()),
                        Column(
                            children: qty
                                .map((i) => Column(
                                      children: [
                                        Text(i.toString()),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ))
                                .toList()),
                      ],
                    ),
                  ),
                  Divider(thickness: 2, color: Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
