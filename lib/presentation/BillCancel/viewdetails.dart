import 'dart:async';
import 'dart:convert';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

import '../../middleware/app_middleware.dart';
import '../widgets/text_with_tag.dart';
import 'BillCancel.dart';

class BillDetailScreen extends StatefulWidget {
  String order_Status;
  List order_Products = [];
  double order_SubTotal;
  double order_Cgst;
  double order_Sgst;
  double order_Total;
  String order_referenceId;
  String order_Document_Id;

  BillDetailScreen(
      {this.order_Products,
      this.order_Status,
      this.order_SubTotal,
      this.order_Cgst,
      this.order_Sgst,
      this.order_Total,
      this.order_Document_Id,
      this.order_referenceId});

  @override
  BillDetailScreenScreenState createState() => BillDetailScreenScreenState();
}

class BillDetailScreenScreenState extends State<BillDetailScreen>
    with SingleTickerProviderStateMixin {
  _ViewModel _vm;

  @override
  void initState() {
    super.initState();
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  onPress() {
    Navigator.of(context).pop();
  }

  static const platform = const MethodChannel('samples.flutter.dev/print');
  dynamic reference;
  dynamic cancelid;

  postmethod() async {
    // print(
    //     "the value are ${storeCode}==${parlourId}-----${widget.order_referenceId}");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'JSESSIONID=5CB51A84D61FB8626A8866C151F5294A.tomcat1'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://idms-fed.aavin.tn.gov.in/rest/posApi/cancelPOSSaleEntry'));
    // print(
    //     "000000 The Username  - ${_vm.storedetails.storeCode} and parlour id - ${_vm.storedetails.parlourId} 0000000");
    if (_vm.storedetails.storeCode == "P171" ||
        _vm.storedetails.storeCode == "P168") {
      request.bodyFields = {
        'username': "${storeCode}_PM",
        'password': 'Aavin123',
        'tenantId': 'aavin-fed',
        'parlourId': parlourId,
        'referenceId': widget.order_referenceId
      };
    } else {
      request.bodyFields = {
        'username': storeCode,
        'password': 'Aavin123',
        'tenantId': 'aavin-fed',
        'parlourId': parlourId,
        'referenceId': widget.order_referenceId
      };
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String jsonsDataString = await response.stream.bytesToString();
    final jsonData = jsonDecode(jsonsDataString);
    reference = jsonData;

    // print("+++++++++++++++$reference");
    return reference;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      //   onInit: (store) => store.dispatch(new FetchIndentOrder()),
      builder: (context, vm) {
        this._vm = vm;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Order Detail"),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Order Summary",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: Stack(children: <Widget>[
                        Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: widget.order_Status == "1"
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text(
                              widget.order_Status == "1"
                                  ? "Booked"
                                  : "Canceled",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[400]))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2))),
                          Expanded(
                              flex: 2,
                              child: Center(
                                  child: Text("Price",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: widget.order_Products.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        //  debugPrint("currentproducts"+products[index].toString()+this.items[products[index]].toString());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextWithTag(
                                  text: widget.order_Products[index]
                                      ["Product_Code"],
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.order_Products[index]
                                        ["Product_Name"],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Center(
                                      child: Text(
                                    widget.order_Products[index]["No_Of_Items"]
                                        .toString(),
                                  ))),
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                      "₹ ${(widget.order_Products[index]["No_Of_Items"] * widget.order_Products[index]["Product_Price"]).toStringAsFixed(2)}"))
                            ],
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
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
                                  child: Text("₹ ${widget.order_SubTotal}")),
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
                                  child: Text("₹ ${widget.order_Cgst}")),
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
                                  child: Text("₹ ${widget.order_Sgst}")),
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
                                    "₹ ${widget.order_Total}",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.order_Status == "1"
                      ? FractionallySizedBox(
                          widthFactor: 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: TextButton(
                              onPressed: () async {
                                Map tempInventory = _vm.inventoryQuantity;
                                print(tempInventory);

                                await postmethod();
                                var snackBar =
                                    SnackBar(content: Text(reference["responseMessage"],),);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                 cancelid = reference["successMessage"].substring(70,77);
                                //print(cancelid);
                                await _firestore
                                    .collection("POS_Order")
                                    .doc(widget.order_Document_Id)
                                    .update({"order_Status": "2","cancel_referenceId":cancelid});
                                for (String i in tempInventory.keys) {
                                  widget.order_Products.forEach((element) {
                                    if (i ==
                                        element["Product_Code"]) {
                                      print(tempInventory[i]);
                                      print("inside $i");
                                      tempInventory[i]= (tempInventory[i]??0) + element["No_Of_Items"];

                                    } else {
                                      print("outside");
                                    }
                                  });
                                  // tempInventory[i]=FieldValue.increment(widget.idQtyMap[i].floor());
                                  // tempInventory[i]= (tempInventory[i]??0) + widget.order_Products[index]["No_Of_Items"]
                                  //     .toString() ;

                                }
                                print("here $tempInventory");
                                setState(() {
                                  _vm.updateInventory(tempInventory);
                                });
                                FirebaseFirestore ref = FirebaseFirestore.instance;
                                await ref.collection("InventoryChanges").doc(_vm.storedetails.storeCode).update(tempInventory);
                                // //print(widget.order_referenceId);
                                Timer(
                                  Duration(seconds: 3),
                                  () {
                                    Navigator.of(context).pop(
                                      MaterialPageRoute(
                                        builder: (context) => BillCancel(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final List dispatchList;
  final Map inventoryQuantity;
  final Function(Map inventory) updateInventory;
  final StoreDetails storedetails;

  _ViewModel(this.dispatchList, this.inventoryQuantity, this.updateInventory,
      this.storedetails);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        store.state.dispatchedList,
        store.state.inventoryQuantity,
        (inventory) => store
            .dispatch(UpdateInventoryQuantity(inventoryQuantity: inventory)),
        store.state.storeDetails);
  }
}
// class _ViewModel {
//   final StoreDetails storedetails;
//   final bool isLoading;
//   final User user;
//
//   final Order order;
//   final Stock stock;
//   final List<Product> products;
//
//   //final List<IndentOrder> orderHistoryAry;
//   final Cart cart;
//   final PointOfSaleOrder pointOfSaleOrder;
//
//   final int phoneNumber;
//   final Function() editorder;
//   final Function() initStockEdit;
//   final Function() signOut;
//   final Function() orderhistory;
//   final Function() fetchIndentOrder;
//   final Function() resetIndent;
//
//   _ViewModel(
//       this.storedetails,
//       this.isLoading,
//       this.user,
//       this.order,
//       this.stock,
//       this.products,
//       this.cart,
//       this.editorder,
//       this.initStockEdit,
//       this.signOut,
//       this.phoneNumber,
//       this.orderhistory,
//       this.fetchIndentOrder,
//       // this.orderHistoryAry,
//       this.pointOfSaleOrder,
//       this.resetIndent);
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     //  debugPrint(store.state.indentOrderObj.totalItem.toString());
//     return _ViewModel(
//       store.state.storeDetails,
//       store.state.isLoading,
//       store.state.currentUser,
//       store.state.order,
//       store.state.stock,
//       store.state.products,
//       store.state.cart,
//       () => store.dispatch(NavigateAction(AppRoutes.editorder)),
//       () => store.dispatch(InitStockEditAction()),
//       () => store.dispatch(AuthSignOutAction()),
//       store.state.phoneNumber,
//       () => store.dispatch(NavigateAction(AppRoutes.orderhistory)),
//       () => store.dispatch(FetchIndentOrder()),
//       //store.state.indentOrder,
//       store.state.pointOfSaleOrder,
//       () => store.dispatch(OnUpdateIndentOrder()),
//     );
//   }
// }
