import 'dart:convert';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:aavinposfro/sharedpreference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

import '../../../middleware/app_middleware.dart';
import '../../../routes.dart';
import '../../widgets/text_with_tag.dart';

class ItemSummary extends StatefulWidget {
  @override
  _ItemSummaryState createState() => _ItemSummaryState();
}

class _ItemSummaryState extends State<ItemSummary> {
  _ViewModel _vm;

  @override
  void initState() {
    super.initState();
  }

  DateTime currentdate = DateTime.now();
  DateTime cur = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  List ItemSale = [];
  List selectedItemSale = [];
  String selectedDate = "";
  List<Map<dynamic, dynamic>> Itemwisemap = [];
  double cgst = 0.0;
  double igst = 0.0;
  double sgst = 0.0;
  double subtotal = 0.0;
  double total = 0.0;
  String iTem = "";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      onInit: (store) async {
        await store.dispatch(new FetchOrder());
      },
      //   onInit: (store) => store.dispatch(new FetchIndentOrder()),
      builder: (context, vm) {
        this._vm = vm;
        return Scaffold(
          appBar: AppBar(
            title: Text("Order Detail"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("FRO_Order")
                .
            where('Store_Code', isEqualTo: SharedPrefService.pref.getString('storeId').toString())
                .where('Date', isEqualTo: formatter.format(currentdate))
                // .where('status', isEqualTo: 1)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //print(snapshot.data);
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              //print("here ${snapshot.data.docs.length}");
              List data = snapshot.data.docs;

              ItemSale.clear();
              cgst = 0.0;
              igst = 0.0;
              sgst = 0.0;
              subtotal = 0.0;
              total = 0.0;
              data.forEach((element) {
                element["Products"].forEach((element2) {
                  ItemSale.add(element2);

//print("ele 2 $element2");
                  cgst += element2["Product_Cgst"];
                  igst += element2["Product_Igst"];
                  sgst += element2["Product_Sgst"];
                  // subtotal+=  element2["Product_BasicPrice"];
                  total = cgst + igst + sgst + subtotal;
                });
              });
              //print(" total  ${cgst}   +  $igst  + $sgst   = $subtotal   + $total");
              //print(" Itemsale ${ItemSale}");
              //print(" Itemsale Length ${ItemSale.length}");

              Map<String, Map<String, dynamic>> uniqList = {};
              List<String> keys = [];

              ItemSale.forEach((element) {
                keys.add(element["Product_Code"]);
              });

              Set setlist = Set<String>();
              setlist = keys.toSet();

              setlist.forEach((uniqProductKey) {
                uniqList[uniqProductKey] = {};
              });
              setlist.forEach((uniqProductKey) {
                uniqList[uniqProductKey] = {};
              });
              ItemSale.forEach((element) {
                String id = element["Product_Code"];

                if (uniqList[id].isEmpty) {
                  uniqList[id] = element;
                } else {
                  int totalcount =
                      uniqList[id]["No_Of_Items"] + element["No_Of_Items"];

                  uniqList[id]["No_Of_Items"] = totalcount;
                  uniqList[id]["Product_Price"] =
                      uniqList[id]["Product_Price"] ;
                }
              });

              Itemwisemap = uniqList.values.toList();

              //print(Itemwisemap);
              selectedItemSale.clear();
              Itemwisemap.forEach((element) {
                //print("Itemwisemap ${element}");
                subtotal +=
                    element["Product_Price"] * element["No_Of_Items"];
                if (iTem == element["Product_Code"]) {
                  selectedItemSale.add(element);
                }
              });
              //print("selectedItemSale ${selectedItemSale}");
              Future<void> _selectDate(BuildContext context) async {
                cgst = 0.0;
                igst = 0.0;
                sgst = 0.0;
                subtotal = 0.0;
                total = 0.0;
                final DateTime pickedDate = await showDatePicker(
                    context: context,
                    initialDate: currentdate,
                    firstDate: DateTime(2015),
                    lastDate: cur);
                if (pickedDate != null && pickedDate != currentdate)
                  setState(() {
                    String date = formatter.format(pickedDate);
                    // ////print(date);
                    currentdate = pickedDate;
                  });
                //print("currentdate ${formatter.format(currentdate)}");
              }

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Order Summary",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Date :",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                            Expanded(
                              flex: 5,
                              child: InkWell(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: Text(
                                              "${formatter.format(currentdate)}"),
                                        ),
                                        Icon(
                                          Icons.calendar_today_sharp,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 3.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Item ID :",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        iTem = value;
                                      });
//print(value);
                                    },
                                  )),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 3.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
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
                      SizedBox(
                        height: 10,
                      ),
                      iTem == ""
                          ? ListView.builder(
                              shrinkWrap: true, // 1st add
                              physics: ClampingScrollPhysics(),
                              itemCount: Itemwisemap.length,
                              itemBuilder: (context, index) {
                                //print("here we go $iTem");

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: TextWithTag(
                                                text: Itemwisemap[index]
                                                    ["Product_Code"],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 10,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  Itemwisemap[index]
                                                      ["Product_Name"],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Center(
                                            child: Text(
                                          Itemwisemap[index]["No_Of_Items"]
                                              .toString(),
                                        ))),
                                    Expanded(
                                        flex: 1,
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                "₹ ${(Itemwisemap[index]["Product_Price"] * Itemwisemap[index]["No_Of_Items"]).toStringAsFixed(2)}"))),
                                  ],
                                );
                              })
                          : ListView.builder(
                              shrinkWrap: true, // 1st add
                              physics: ClampingScrollPhysics(),
                              itemCount: selectedItemSale.length,
                              itemBuilder: (context, index) {
                                //print("here we go $iTem");

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: TextWithTag(
                                                text: selectedItemSale[index]
                                                    ["Product_Code"],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 10,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  selectedItemSale[index]
                                                      ["Product_Name"],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Center(
                                            child: Text(
                                          selectedItemSale[index]["No_Of_Items"]
                                              .toString(),
                                        ))),
                                    Expanded(
                                        flex: 1,
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                "₹ ${(selectedItemSale[index]["Product_Price"] * selectedItemSale[index]["No_Of_Items"]).toStringAsFixed(2)}"))),
                                  ],
                                );
                              })
                      ,
                      SizedBox(
                        height: 10,
                      ),
                      iTem == ""
                          ? Column(
                              children: [
                                // Row(
                                //   children: <Widget>[
                                //     Expanded(
                                //       flex: 3,
                                //       child: Container(),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child: Text(
                                //         "Sub Total",
                                //       ),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child: Align(
                                //           alignment: Alignment.centerRight,
                                //           child: Text(
                                //               "₹ ${subtotal.toStringAsFixed(2)}")),
                                //     )
                                //   ],
                                // ),
                                // Row(
                                //   children: <Widget>[
                                //     Expanded(
                                //       flex: 3,
                                //       child: Container(),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child: Text(
                                //         "CGST",
                                //       ),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child: Align(
                                //           alignment: Alignment.centerRight,
                                //           child: Text(
                                //               "₹ ${cgst.toStringAsFixed(2)}")),
                                //     )
                                //   ],
                                // ),
                                // Row(
                                //   children: <Widget>[
                                //     Expanded(
                                //       flex: 3,
                                //       child: Container(),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child: Text("SGST"),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child: Align(
                                //           alignment: Alignment.centerRight,
                                //           child: Text(
                                //               "₹ ${sgst.toStringAsFixed(2)}")),
                                //     )
                                //   ],
                                // ),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "₹ ${(subtotal).toStringAsFixed(2)}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : selectedItemSale.length == 0
                              ? Container()
                              : Column(
                                  children: [
                                    // Row(
                                    //   children: <Widget>[
                                    //     Expanded(
                                    //       flex: 3,
                                    //       child: Container(),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Text(
                                    //         "Sub Total",
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Align(
                                    //           alignment: Alignment.centerRight,
                                    //           child: Text(
                                    //               "₹ ${(selectedItemSale[0]["Product_Price"] * selectedItemSale[0]["No_Of_Items"]).toStringAsFixed(2)}")),
                                    //     )
                                    //   ],
                                    // ),
                                    // Row(
                                    //   children: <Widget>[
                                    //     Expanded(
                                    //       flex: 3,
                                    //       child: Container(),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Text(
                                    //         "CGST",
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Align(
                                    //           alignment: Alignment.centerRight,
                                    //           child: Text(
                                    //               "₹ ${selectedItemSale[0]["Product_Cgst"].toStringAsFixed(2)}")),
                                    //     )
                                    //   ],
                                    // ),
                                    // Row(
                                    //   children: <Widget>[
                                    //     Expanded(
                                    //       flex: 3,
                                    //       child: Container(),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Text("SGST"),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Align(
                                    //           alignment: Alignment.centerRight,
                                    //           child: Text(
                                    //               "₹ ${selectedItemSale[0]["Product_Sgst"].toStringAsFixed(2)}")),
                                    //     )
                                    //   ],
                                    // ),
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "₹ ${(selectedItemSale[0]["Product_Price"] * selectedItemSale[0]["No_Of_Items"]).toStringAsFixed(2)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                      SizedBox(
                        height: 20,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextButton(
                            onPressed: () async {
                              //print(Itemwisemap);

                              int timestamp =
                                  DateTime.now().millisecondsSinceEpoch;
                              //print(json.encode(jsonEncode(Itemwisemap)));

                              if (selectedItemSale.length != 0) {
                                var cal1 = selectedItemSale[0]
                                        ["Product_Price"] *
                                    selectedItemSale[0]["No_Of_Items"];


                                const platform = const MethodChannel(
                                    'samples.flutter.dev/print');
                                bool isSuccess = await platform
                                    .invokeMethod('print', <String, dynamic>{
                                  'data':
                                      json.encode(jsonEncode(selectedItemSale)),
                                  'orderID': timestamp.toString(),
                                  'cgst': "0.0",
                                  'igst': "0.0",
                                  'sgst': "0.0",
                                  'subtotal': "0.0",
                                  'total': (cal1 ).toStringAsFixed(2),
                                  'address': _vm.storedetails.storeAddress,
                                  'paymentmethod': "Cash",
                                  'storecode': _vm.storedetails.storeCode,
                                });
                              } else {
                                const platform = const MethodChannel(
                                    'samples.flutter.dev/print');
                                bool isSuccess = await platform
                                    .invokeMethod('print', <String, dynamic>{
                                  'data': json.encode(jsonEncode(Itemwisemap)),
                                  'orderID': timestamp.toString(),
                                  'cgst': "0.0",
                                  'igst': "0.0",
                                  'sgst': "0.0",
                                  'subtotal': "0.0",
                                  'total': (subtotal).toStringAsFixed(2),
                                  'address':SharedPrefService.pref.getString('storeName').toString(),
                                  'paymentmethod': "Cash",
                                  'storecode': SharedPrefService.pref.getString('storeId').toString(),
                                });
                              }
                            },
                            child: Text(
                              "Print",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final StoreDetails storedetails;
  final bool isLoading;

  final Order order;
  final Stock stock;
  final List<Product> products;

  //final List<IndentOrder> orderHistoryAry;
  final Cart cart;
  final PointOfSaleOrder pointOfSaleOrder;

  final int phoneNumber;
  final Function() editorder;
  final Function() initStockEdit;
  final Function() signOut;
  final Function() orderhistory;
  final Function() fetchIndentOrder;
  final Function() resetIndent;

  _ViewModel(
      this.storedetails,
      this.isLoading,
      this.order,
      this.stock,
      this.products,
      this.cart,
      this.editorder,
      this.initStockEdit,
      this.signOut,
      this.phoneNumber,
      this.orderhistory,
      this.fetchIndentOrder,
      // this.orderHistoryAry,
      this.pointOfSaleOrder,
      this.resetIndent);

  static _ViewModel fromStore(Store<AppState> store) {
    //  debugPrint(store.state.indentOrderObj.totalItem.toString());
    return _ViewModel(
      store.state.storeDetails,
      store.state.isLoading,

      store.state.order,
      store.state.stock,
      store.state.products,
      store.state.cart,
      () => store.dispatch(NavigateAction(AppRoutes.home)),
      () => store.dispatch(InitStockEditAction()),
      () => store.dispatch(AuthSignOutAction()),
      store.state.phoneNumber,
      () => store.dispatch(NavigateAction(AppRoutes.orderhistory)),
      () => store.dispatch(FetchIndentOrder()),
      //store.state.indentOrder,
      store.state.pointOfSaleOrder,
      () => store.dispatch(OnUpdateIndentOrder()),
    );
  }

  void dispatch(UpdatePosSummary updatePosSummary) {}
}
