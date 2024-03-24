import 'dart:async';
import 'dart:ui';

import 'package:aavinposfro/sharedpreference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

import '../../../actions/actions.dart';
import '../../../actions/auth_actions.dart';
import '../../../middleware/app_middleware.dart';
import '../../../models/PointOfSaleOrderModel.dart';
import '../../../models/app_state.dart';
import '../../../models/indent.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../models/stock.dart';
import '../../../routes.dart';
import '../Summary/pdf.dart';
import 'SettlementViewStatement.dart';

class Settlement extends StatefulWidget {
  @override
  State<Settlement> createState() => _SettlementState();
}

class _SettlementState extends State<Settlement> {
  bool isLoading = false;

  int cash = 0;

  DateTime dateTime = null;

  @override
  void initState() {
    super.initState();
    initSetup();
  }

  initSetup() async {
    await fetchPosDataFromFirebaseFirestore();
  }

  Widget build(BuildContext context) {
    var cash;
    var excessvalue;
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Detail"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Settlement",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Date :",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DateTimePicker(
                                  initialValue: DateTime.now().subtract(Duration(seconds: 1)).toString(),
                                  firstDate: DateTime(2000),
                                  lastDate:  DateTime.now(),
                                  //dateLabelText: selectedDate==""?'Date':"",
                                  // fieldHintText: "date",
                                  dateHintText: "Select a date to filter",
                                  onChanged: (val) {
                                    overallpayment=0;
                                    DateTime d =
                                        DateFormat("yyyy-MM-dd").parse(val);
                                    dateTime = d;
// //print(dateTime);

                                    setState(() {});
                                  },
                                  validator: (val) {
                                    return null;
                                  },
                                  onSaved: (val) {},
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
                              color: Colors.grey[300],
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
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
                        height: 25,
                      ),

                      // Text(
                      //     "Cash ${getPaymentCount(paymentMethod: 1, dateTime: this.dateTime == null ? null : this.dateTime)}"),
                      // Text(
                      //     "Card   ${getPaymentCount(paymentMethod: 2, dateTime: this.dateTime == null ? null : this.dateTime)}"),
                      // Text(
                      //     "Upi  ${getPaymentCount(paymentMethod: 3, dateTime: this.dateTime == null ? null : this.dateTime)}"),
                      // Text(
                      //     "Denzo  ${getPaymentCount(paymentMethod: 4, dateTime: this.dateTime == null ? null : this.dateTime)}"),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Expanded(
                      //         flex: 2,
                      //         child: Text(
                      //           'Cash:',
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 15,
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 4,
                      //         child: TextFormField(
                      //             decoration: new InputDecoration(
                      //               labelText: "",
                      //               fillColor: Colors.white,
                      //               border: new OutlineInputBorder(
                      //                 borderRadius:
                      //                     new BorderRadius.circular(10.0),
                      //                 borderSide: new BorderSide(),
                      //               ),
                      //             ),
                      //             keyboardType: TextInputType.number,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 cash = value;
                      //               });
                      //
                      //               //print(cash);
                      //             }),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      /////ranjith code
                      Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(20),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    //color of shadow
                                    spreadRadius: 5,
                                    //spread radius
                                    blurRadius: 7,
                                    // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Cash",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("-",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "${getPaymentCount(paymentMethod: "Cash Payment", dateTime: this.dateTime == null ? null : this.dateTime).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(20),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    //color of shadow
                                    spreadRadius: 5,
                                    //spread radius
                                    blurRadius: 7,
                                    // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Card",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("-",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "${getPaymentCount(paymentMethod: "Card Payment", dateTime: this.dateTime == null ? null : this.dateTime).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(20),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    //color of shadow
                                    spreadRadius: 5,
                                    //spread radius
                                    blurRadius: 7,
                                    // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "UPI",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("-",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "${getPaymentCount(paymentMethod: "UPI Payment", dateTime: this.dateTime == null ? null : this.dateTime).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(20),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    //color of shadow
                                    spreadRadius: 5,
                                    //spread radius
                                    blurRadius: 7,
                                    // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "ThirdParty",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("-",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "${getPaymentCount(paymentMethod: "ThirdParty Payment", dateTime: this.dateTime == null ? null : this.dateTime).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(20),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    //color of shadow
                                    spreadRadius: 5,
                                    //spread radius
                                    blurRadius: 7,
                                    // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("-",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "${overallpayment.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        ],
                      ),
                      /////ranjith code
                      // FlatButton(
                      //   color: Colors.blue,
                      //   onPressed: () async {
                      //     if(dateTime==null&&cash==null){
                      //       //print("++++++");
                      //     }
                      //     else {
                      //       //print("------------");
                      //       //print(dateTime);
                      //       //print(totalvalue);
                      //     }
                      //     // Navigator.push(
                      //     //     context,
                      //     //     MaterialPageRoute(
                      //     //         builder: (context) => SettlementViewStatement(
                      //     //               dateTime: dateTime,
                      //     //               cash:
                      //     //                  "data",
                      //     //               excessvalue: excessvalue,
                      //     //             )));
                      //     // excessvalue= "${getPaymentCount(paymentMethod: 1, dateTime: this.dateTime == null ? null : this.dateTime)}" ;
                      //     // if (cash=="${getPaymentCount(paymentMethod: 1, dateTime: this.dateTime == null ? null : this.dateTime)}"){
                      //     //   //print("+++++++");
                      //     //   excessvalue="0";
                      //     // }
                      //     //
                      //     // //   else if(cash<="${getPaymentCount(paymentMethod: 1, dateTime: this.dateTime == null ? null : this.dateTime)}"){
                      //     // //   cash-"${getPaymentCount(paymentMethod: 1, dateTime: this.dateTime == null ? null : this.dateTime)}"
                      //     // // }
                      //     //
                      //     //   else {
                      //     //     var hhh= cash-"${getPaymentCount(paymentMethod: 1, dateTime: this.dateTime == null ? null : this.dateTime)}";
                      //     //     //print("$hhh");
                      //     //       //print("data");
                      //     // };
                      //   },
                      //   child: Text('Submit'),
                      // ),

                      // OrderSum(),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ));
  }

  List convertedMapData = [];
  _ViewModel _vm;
  fetchPosDataFromFirebaseFirestore() async {
    // print("+++++++++++++${storeCode}111");

    QuerySnapshot posOrderData =
        await FirebaseFirestore.instance.collection("FRO_Order").  where('Store_Code', isEqualTo: SharedPrefService.pref.getString('storeId').toString()).get();
    List<DocumentSnapshot> docs = posOrderData.docs;

    docs.forEach((element) {
      Map m = element.data();
      m["Created_At"] = (m["Created_At"] as Timestamp).toDate();
print("heree $m");
      convertedMapData.add(m);
    });
    setState(() {});
  }
  double overallpayment=0;
  double totalvalue;
  getPaymentCount({DateTime dateTime = null, String paymentMethod}) {



    int count = 0;
      totalvalue=0;
    if (dateTime == null) {

      convertedMapData.forEach((element) {
        if (element["Payment_Method"] == paymentMethod) {
          var data = element["Order_Total"];

          // //print(
          //     "+++++++++++++++++++++++++++++++++++++++++++++----------------------------${data}");

          // count++;
        }
        ;
      });
    }

    if (dateTime != null) {
      totalvalue=0;

      convertedMapData.forEach((element) {

        // var data = element["Order_Total"];


        // if (dateTime.difference(element["Created_At"]).inDays == 0) {
        if (element["Created_At"].toString().substring(0,10) == dateTime.toString().substring(0,10)) {

          if (element["Payment_Method"] == paymentMethod) {
            // if (element["Payment_Method"] == paymentMethod) {

              overallpayment += element["Order_Total"];
              totalvalue += element["Order_Total"];
              // count++;
              //print("count added");
            }
          }

          ;
        // }
      });
    }

     //print("the payment method is ${paymentMethod} and count is ${count} and total value is ${totalvalue}");

    setState(() {
      overallpayment=overallpayment;
    });

    return totalvalue;
  }
}

// getPaymentsum( paymentMethod) {
//   if (element["Payment_Method"] == paymentMethod) {
//     count++;
//     //print("count added");
//   }
// }

class _ViewModel {
  final Function(List disList) updateDispatchList;
  final bool isLoading;
  final Order order;
  final Stock stock;
  final List<Product> products, searchProducts;
  final Cart cart;
  final int phoneNumber;
  final Function() checkout;
  final Function(String route) navigation;
  final Function() initStockEdit;
  final Function() signOut;
  final Function() orderhistory;
  final Function(PointOfSaleOrder pos) updatePos;
  final Function() resetOrder;
  final Function(String text) updateSearch;
  final StoreDetails storedetails;
  final Function(String product, int quantity, Completer<int> completer)
  updateCart;

  _ViewModel(
      this.updateDispatchList,
      this.isLoading,
      this.order,
      this.stock,
      this.products,
      this.cart,
      this.checkout,
      this.initStockEdit,
      this.signOut,
      this.phoneNumber,
      this.orderhistory,
      this.resetOrder,
      this.storedetails,
      this.updateCart,
      this.updatePos,
      this.navigation,
      this.searchProducts,
      this.updateSearch);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
            (disList) =>
            store.dispatch(UpdateDispatchList(dispatchedList: disList)),
        store.state.isLoading,
        store.state.order,
        store.state.stock,
        store.state.products,
        store.state.cart,
            () => store.dispatch(NavigateAction(AppRoutes.checkout)),
            () => store.dispatch(InitStockEditAction()),
            () => store.dispatch(AuthSignOutAction()),
        store.state.phoneNumber,
            () => store.dispatch(NavigateAction(AppRoutes.orderhistory)),
            () => store.dispatch(ResetOrder("Success")),
        store.state.storeDetails,
            (product, quantity, completer) =>
            store.dispatch(UpdateCartAction(product, quantity, completer)),
            (posorderModel) => store.dispatch(UpdatePosSale(posorderModel)),
            (route) => store.dispatch(NavigateAction(route)),
        store.state.searchProducts,
            (text) => store.dispatch(SearchProduct(text)));
  }
}
