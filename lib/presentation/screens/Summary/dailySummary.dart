// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:convert';
//
// import 'package:aavinposfro/actions/actions.dart';
// import 'package:aavinposfro/actions/auth_actions.dart';
// import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
// import 'package:aavinposfro/models/app_state.dart';
// import 'package:aavinposfro/models/indent.dart';
// import 'package:aavinposfro/models/indent_order.dart';
// import 'package:aavinposfro/models/order.dart';
// import 'package:aavinposfro/models/product.dart';
// import 'package:aavinposfro/models/stock.dart';
// import 'package:aavinposfro/presentation/screens/home/indent/products_list.dart';
// import 'package:aavinposfro/presentation/screens/orderhistory/OrderList.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
//
// import '../../../routes.dart';
// import 'package:aavinposfro/presentation/screens/Summary/pdf.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_format/date_format.dart';
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
//
// import '../../../actions/actions.dart';
// import '../../../actions/auth_actions.dart';
// import '../../../models/PointOfSaleOrderModel.dart';
// import '../../../models/app_state.dart';
// import '../../../models/indent.dart';
// import '../../../models/order.dart';
// import '../../../models/product.dart';
// import '../../../models/stock.dart';
// import '../../widgets/text_with_tag.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
//
// class DailySummaryScreen extends StatefulWidget {
//   @override
//   State<DailySummaryScreen> createState() => _DailySummaryScreenState();
// }
//
// var filterdate;
//
// class _DailySummaryScreenState extends State<DailySummaryScreen> {
//   bool isLoading = false;
//
//   DateTime dateTime;
//
//   @override
//   void initState() {
//     initSetup();
//   }
//
//   initSetup() async {
//     await fetchDataFromFirebase();
//   }
//
//   _ViewModel _vm;
//   List productList;
//
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, _ViewModel>(
//         converter: _ViewModel.fromStore,
//         //   onInit: (store) => store.dispatch(new FetchIndentOrder()),
//         builder: (context, vm) {
//           this._vm = vm;
//           return Scaffold(
//               appBar: AppBar(
//                 title: Text("Order Detail"),
//                 backgroundColor: Theme.of(context).primaryColor,
//               ),
//               body: isLoading
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : SingleChildScrollView(
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               "Order Summary",
//                               style: Theme.of(context).textTheme.subtitle1,
//                             ),
//                             Container(
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Expanded(
//                                       flex: 1,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           "Date :",
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       )),
//                                   Expanded(
//                                     flex: 5,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: DateTimePicker(
//                                         initialValue: '',
//                                         firstDate: DateTime(2000),
//                                         lastDate: DateTime(2100),
//                                         //dateLabelText: selectedDate==""?'Date':"",
//                                         // fieldHintText: "date",
//                                         dateHintText: "Select a date to filter",
//                                         onChanged: (val) {
//                                           var d = DateFormat("yyyy-MM-dd")
//                                               .parse(val);
//                                           filterdate =
//                                               d.toString().substring(0, 10);
//
//                                           filterDate(filterdate);
//
//                                           setState(() {});
//                                         },
//                                         validator: (val) {
//                                           return null;
//                                         },
//                                         onSaved: (val) {},
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey[300],
//                                     offset: const Offset(
//                                       5.0,
//                                       5.0,
//                                     ),
//                                     blurRadius: 10.0,
//                                     spreadRadius: 2.0,
//                                   ), //BoxShadow
//                                   BoxShadow(
//                                     color: Colors.white,
//                                     offset: const Offset(0.0, 0.0),
//                                     blurRadius: 0.0,
//                                     spreadRadius: 0.0,
//                                   ), //BoxShadow
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                     flex: 1,
//                                     child: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           "ID",
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         ))),
//                                 SizedBox(width: 20),
//                                 Expanded(
//                                   flex: 9,
//                                   child: Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         "Product Name",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       )),
//                                 ),
//                                 Expanded(
//                                   flex: 6,
//                                   child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         "Quantity",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       )),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         "Total Value",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       )),
//                                 ),
//                               ],
//                             ),
//                             filterdData.isEmpty
//                                 ? Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "No items found",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                       Text(
//                                         "Please select Date",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ],
//                                   )
//                                 : ListView.builder(
//                                     shrinkWrap: true,
//                                     primary: false,
//                                     itemCount: filterdData.length,
//                                     itemBuilder: (_, index) {
//                                       productList =
//                                           filterdData[index]["Products"];
//
//                                       return ListView.builder(
//                                           shrinkWrap: true,
//                                           primary: false,
//                                           itemCount: productList.length,
//                                           itemBuilder: (_, pos) {
//                                             return Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   // SizedBox(width: 20,),
//                                                   Expanded(
//                                                     flex: 2,
//                                                     child: TextWithTag(
//                                                       text: productList[pos]
//                                                           ["Product_Code"],
//                                                     ),
//                                                   ),
//                                                   // SizedBox(width: 40,),
//                                                   Expanded(
//                                                     flex: 10,
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Text(
//                                                           productList[pos]
//                                                               ["Product_Name"]),
//                                                     ),
//                                                   ),
//                                                   // SizedBox(width: 60,),
//                                                   Expanded(
//                                                     flex: 3,
//                                                     child: Container(
//                                                       child: Text(
//                                                           "${productList[pos]["No_Of_Items"]}"),
//                                                       alignment:
//                                                           Alignment.center,
//                                                     ),
//                                                   ),
//                                                   // SizedBox(width: 20,),
//                                                   Expanded(
//                                                     flex: 2,
//                                                     child: Align(
//                                                       alignment:
//                                                           Alignment.topLeft,
//                                                       child: Text(data[index]
//                                                               ["Order_Total"]
//                                                           .toString()),
//                                                     ),
//                                                   ),
//                                                 ]);
//                                           });
//                                     }),
//                             FractionallySizedBox(
//                               widthFactor: 0.4,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.blueAccent,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(20))),
//                                 child: TextButton(
//                                   onPressed: () async {
//                                     List array = [];
//                                     await filterdData.forEach((element) async {
//                                       //print("data ${filterData.toString()}");
//                                       array.add(filterData);
//                                     });
//                                     //print(array.length);
// //                           List<Map<dynamic,dynamic>> map = (array.map((e) {
// //
// //                             //print("printing price${e.toMap()}");
// //                             return e.toMap();
// //                           }).toList());
//                                     //print("data ${filterData[0]["Products"]}");
//                                     //print(
//                                         "json encode${json.encode(jsonEncode(filterdData[0]["Products"]))}");
//                                     const platform = const MethodChannel(
//                                         'samples.flutter.dev/print');
//                                     bool isSuccess = await platform
//                                         .invokeMethod(
//                                             'print', <String, dynamic>{
//                                       //'data': json.encode(jsonEncode(filterdData[0]["Products"])),
//                                       'data': json.encode(jsonEncode(
//                                           filterdData[0]["Products"])),
//                                       'orderID': "0.0",
//                                       'cgst': "0.0",
//                                       'igst': "0.0",
//                                       'sgst': "0.0",
//                                       'subtotal': "0.0",
//                                       'total': "0.0",
//                                       'address': _vm.storedetails.storeAddress,
//                                       'paymentmethod': "Cash",
//                                       'storecode': _vm.storedetails.storeCode,
//                                     });
//                                   },
//                                   child: Text(
//                                     "Print",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ));
//         });
//   }
//
//   List<DocumentSnapshot> filterData = [];
//
//   List data = [];
//   final now = DateTime.now();
//
//   Future fetchDataFromFirebase() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     QuerySnapshot posOrderData =
//         await FirebaseFirestore.instance.collection("POS_Order").get();
//
//     filterData = posOrderData.docs;
//
//     filterData.forEach((element) {
//       Map m = element.data();
//
//       m["Created_At"] =
//           (m["Created_At"] as Timestamp).toDate().toString().substring(0, 10);
//
//       data.add(m);
//     });
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   List pdf = [];
//   List filterdData = [];
//   List newList = [];
//
//   filterDate(filterdate) async {
//     filterdData.clear();
//     pdf.clear();
//     setState(() {
//       isLoading = true;
//     });
//     data.forEach((element) {
//       if (element["Created_At"] == filterdate) {
//         // pdf.add(element);
//
//         //print("here");
//         //print(filterdData);
//         if (filterdData.length == 0) {
//           //print("if loop");
//           element["Products"].forEach((element5) {
//             //print("heheheheheh  $element5");
//             filterdData.add(element5);
//           });
//           // filterdData.add(element);
//         } else {
//           //print("else loop");
//           filterdData.asMap().forEach((index, element2) {
//             //print(element2["Products"]);
//             // element2["Products"].forEach((element3){
//             // //print("element3 - $element3");
//             // //print("element - $element");
//             ///
//             element["Products"].forEach((element4) {
//               if (element2["Product_Code"] == element4["Product_Code"]) {
//                 //print("if product loop");
//                 newList = filterdData;
//                 newList[index]["No_Of_Items"] += element4["No_Of_Items"];
//                 newList[index]["Product_Price"] += element4["Product_Price"];
//                 // element4["No_Of_Items"]+=["No_Of_Items"];
//               } else {
//                 //print("if else loop");
//                 //print("element4 - $element4");
//                 newList.add(element4);
//                 //print("11111 - $newList");
//               }
//               // else{
//               //   //print("if else loop");
//               //   // filterdData.add(element);
//               // }
//             });
//
//             // });
//           });
//         }
//
//         // filterdData.add(element);
//
//         //print("filter data - ${filterdData}");
//         setState(() {
//           _vm.dispatch(UpdatePosSummary(posSummary: filterdData));
//         });
//         //print("overall $newList");
//       } else {
//         //print("i am here");
//       }
//     });
//
//     setState(() {
//       isLoading = false;
//     });
//   }
// }
//
// class _ViewModel {
//   final StoreDetails storedetails;
//   final bool isLoading;
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
//
//       store.state.order,
//       store.state.stock,
//       store.state.products,
//       store.state.cart,
//       () => store.dispatch(NavigateAction(AppRoutes.home)),
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
//
//   void dispatch(UpdatePosSummary updatePosSummary) {}
// }
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

class DailySummary extends StatefulWidget {
  @override
  _DailySummaryState createState() => _DailySummaryState();
}

class _DailySummaryState extends State<DailySummary> {
  _ViewModel _vm;

  @override
  void initState() {
    super.initState();
  }

  DateTime currentdate = DateTime.now();
  DateTime cur = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  List ItemSale = [];
  String selectedDate = "";
  List<Map<dynamic, dynamic>> Itemwisemap = [];
  double cgst = 0.0;
  double igst = 0.0;
  double sgst = 0.0;
  double subtotal = 0.0;
  double total = 0.0;

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
                .collection("FRO_Order").
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
                  // total =cgst+igst+sgst+subtotal ;
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

              Itemwisemap.forEach((element) {
                subtotal += element["Product_Price"] * element["No_Of_Items"];
                total = cgst + igst + sgst + subtotal;
              });
              print(Itemwisemap);

              print(subtotal);
              String iTem = "";
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
                     Itemwisemap.length!=0 ?
                    ListView.builder(
                    shrinkWrap: true, // 1st add
                    physics: ClampingScrollPhysics(),
                  itemCount: Itemwisemap.length,
                  itemBuilder: (context, index) {
                    //print(ItemSale);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    padding: const EdgeInsets.all(8.0),
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
                                    "₹ ${(Itemwisemap[index]["Product_Price"]* Itemwisemap[index]["No_Of_Items"] ).toStringAsFixed(2)}"))),
                      ],
                    );
                  })
                      :Center(child: Text("No items found.")),

                      SizedBox(
                        height: 10,
                      ),
                      Column(
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
                          //           child: Text("₹ ${subtotal.toStringAsFixed(2)}")),
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
                          //           child: Text("₹ ${cgst.toStringAsFixed(2)}")),
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
                          //           child: Text("₹ ${sgst.toStringAsFixed(2)}")),
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
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "₹ ${(subtotal).toStringAsFixed(2)}",
                                      style:
                                          Theme.of(context).textTheme.headline5,
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
                              print(Itemwisemap);

                              int timestamp =
                                  DateTime.now().millisecondsSinceEpoch;
                              //print(json.encode(jsonEncode(Itemwisemap)));
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
