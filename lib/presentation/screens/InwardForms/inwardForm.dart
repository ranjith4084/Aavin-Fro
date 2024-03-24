import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../Settings/Profile.dart';
import '../../../actions/actions.dart';
import '../../../actions/auth_actions.dart';
import '../../../models/PointOfSaleOrderModel.dart';
import '../../../models/app_state.dart';
import '../../../models/indent.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../models/stock.dart';
import '../../../routes.dart';
import '../../../utils/colors_utils.dart';

class InwardForm extends StatefulWidget {
  @override
  _InwardFormState createState() => _InwardFormState();
}

class _InwardFormState extends State<InwardForm> {


  // String productName = "Not Found";
  int quantity;
  DateTime dateTime = DateTime.now();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  List kitchenData;
  List Product;

  getKitchenData() async {
    var data =
        (await _ref.collection("IDMS_Product").get()).docs.map((element) {
      // //print("+++++++++++++1111111111");
      return element.data();
    }).toList();
    setState(() {
      kitchenData = data;
    });
    // //print(kitchenData);
  }

  @override
  void initState() {
    super.initState();
    getKitchenData();
    initSetup();
  }

  initSetup() async {
    await fetchPosDataFromFirebaseFirestore();
  }

  fetchPosDataFromFirebaseFirestore() async {
    var data =
    (await _ref.collection("IDMS_Product").get()).docs.map((element) {
      // //print("+++++++++++++1111111111");
      return element.data();
    }).toList();
    setState(() {
      kitchenData = data;
    });
    // //print(kitchenData);
    // QuerySnapshot posOrderData = await FirebaseFirestore.instance
    //     .collection("InventoryChanges").doc("P167").get();
    // QuerySnapshot posOrderData = (await FirebaseFirestore.instance
    //     .collection("InventoryChanges")
    //     .doc("P167")
    //     .get();
    // //print("${posOrderData.docs.length}");
    // List<DocumentSnapshot> docs = posOrderData.docs;
    // //print("++++${docs.length}");
  }

  // getInventoryData()async
  // {
  //   var data =(await  _ref.collection("InventoryChanges").doc().get()).docs.map((element) {
  //     return element.data();
  //   }).toList();
  //   setState(() {
  //     kitchenData=data;
  //   });
  //   //print(kitchenData);
  // }
  int totalproduct = 0;
  String jsonTags;
  int totalproduct1 = 0;
  int totalproductqty = 0;
  int totalproductqty1 = 0;
  final List productqty1 = [];
  _ViewModel _vm;
  var initial_dropdown = "Please select a Product";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          this._vm = vm;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Inward Entries"),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Select a Product",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 60,
                                  width: 200,
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        color: HexColor('#E0E0E0'),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: DropdownButton<String>(
                                      dropdownColor: HexColor('F2F2F2'),
                                      underline: SizedBox(),
                                      hint: initial_dropdown == null
                                          ? Center(
                                              child: Text("198 - Coffee Milk",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          : Center(
                                              child: Text(
                                                initial_dropdown,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                      isExpanded: true,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      iconSize: 26.0,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      items: [
                                        "198 - Coffee Milk",
                                        "199 - Raw Hot Milk",
                                        "200 - KIT Cups",
                                        "201 - 	KIT Sugar",
                                        "202 - 	KIT Badam Powder",
                                        "203 - KIT Veg Patties",
                                        "204 - TABLE BUTTER",
                                        "205 - CHEESE",
                                        "206 - Vegetables",
                                        "208 - MILK SHAKE MILK",
                                        "211 - Kit French Fries",
                                        "212 - 	KIT Vanilla Ice Cream",
                                        "213 - KIT Chocolate IceCream",
                                        "214 - KIT Pista IceCream",
                                        "215 - KIT Strawberry Ice Cream",
                                        "216 - KIT Mango Ice Cream",
                                        "218 - Pizza Base",
                                        "219 - Burger Bun",
                                        "220 - 	SANDWICH BREAD",
                                        "221 - Vanilla Essence",
                                        "222 - Chocolate Essence",
                                        "223 - Pista Essence",
                                        "225 - Strawberry Essence",
                                        "226 - Mango Essence",
                                        "227 - Pineapple Essence",
                                        "229 - Coffee Powder",
                                        "230 - Tea Powder",
                                        "231- Tea Bag",
                                      ].map(
                                        (val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text(val),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (val) {
                                        setState(
                                          () {
                                            initial_dropdown = val;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(20),
                        //   child: Row(
                        //     children: [
                        //
                        //       Expanded(
                        //           flex: 2,
                        //           child: Text(
                        //             "Product ID",
                        //             textAlign: TextAlign.left,
                        //             style: TextStyle(
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w500),
                        //           )),
                        //       Expanded(
                        //         flex: 5,
                        //         child: Container(
                        //           child: TextFormField(
                        //             validator: (value) {
                        //               if (value != null && value != "") {
                        //                 return null;
                        //               }
                        //               return "Enter Product ID";
                        //             },
                        //             decoration: InputDecoration(
                        //                 enabled: true,
                        //                 border: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20)))),
                        //             onChanged: (value) {
                        //               setState(() {
                        //                 //print("1211212121${_vm.products}");
                        //                 //print(
                        //                     "1211212121${_vm.products.length}");
                        //
                        //                 _vm.products.forEach((element) {
                        //                   //print("1211212121${element.id}");
                        //                   //print("34343446${element.name}");
                        //                   if (element.id == value) {
                        //                     setState(() {
                        //                       productName = element.name;
                        //                       //print("5656565656${productName}");
                        //                       productID = value;
                        //                       //print("5656565656${productID}");
                        //                     });
                        //                     //print(element.name);
                        //                   } else {
                        //                     //print(element.id);
                        //                   }
                        //                 });
                        //
                        //                 // kitchenData.forEach((element) {
                        //                 //   if (element["Product_Id"] == value) {
                        //                 //     setState(() {
                        //                 //       productName =
                        //                 //       element["IDMS_Product_Name"];
                        //                 //       productID = value;
                        //                 //     });
                        //                 //     //print(element["IDMS_Product_Name"]);
                        //                 //   } else {
                        //                 //     //print(element["Product_Id"]);
                        //                 //   }
                        //                 // });
                        //               });
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(20),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //           flex: 2,
                        //           child: Text(
                        //             "Product Name",
                        //             textAlign: TextAlign.left,
                        //             style: TextStyle(
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w500),
                        //           )),
                        //       Expanded(
                        //         flex: 5,
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //               color: Colors.grey[200],
                        //               borderRadius: BorderRadius.all(
                        //                   Radius.circular(20))),
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(20.0),
                        //             child: Text(
                        //               productName,
                        //               style: TextStyle(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.w500),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Product Quantity",
                                    textAlign: TextAlign.left,
                                  )),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value != null && value != "") {
                                        return null;
                                      }
                                      return "Enter Quantity";
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 20, top: 20, bottom: 20),
                                        enabled: true,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    onChanged: (value) {
                                      setState(() {
                                        quantity = int.parse(value);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(20),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //           flex:2,
                        //           child: Text("Date",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                        //       Expanded(
                        //         flex:5,
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //               color: Colors.grey[200],
                        //               borderRadius: BorderRadius.all(Radius.circular(20))
                        //           ),
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(20.0),
                        //             child: CalendarDatePicker(
                        //               onDateChanged: (DateTime value) {
                        //                 setState(() {
                        //                   dateTime=value;
                        //                 });
                        //               },
                        //               lastDate: DateTime(2100),
                        //               initialDate: DateTime.now(),
                        //               firstDate: DateTime.now(),),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        FractionallySizedBox(
                          widthFactor: 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()&& initial_dropdown != "Please select a Product") {
                                  //print("+++++++++");
                                  // //print(productName);
                                  // //print(productID);
                                  //print(quantity);
                                 String productID = initial_dropdown.substring(0, 3);
                                  //print(productID);

                                  ///inward 10

                                  Map<String, dynamic> temp = {};
                                  Map tempInventory = _vm.inventoryQuantity;
                                  //print(_vm.inventoryQuantity.keys);
                                  //print(_vm.inventoryQuantity.values);
                                  String data;
                                  for (String i in _vm.inventoryQuantity.keys) {
                                    //print("11111111111${i}");
                                    //print("2222222222${productID}");
                                    if (i == productID) {
                                      data = i;
                                      //print(i);
                                      //
                                      // //print(productID);
                                      // temp[i] = FieldValue.increment(quantity);
                                      // tempInventory[i] =
                                      //     (tempInventory[i] ?? 0) + quantity;
                                      //
                                      // //print(tempInventory);
                                      // _ref
                                      //     .collection("InventoryChanges")
                                      //     .doc(_vm.storedetails.storeCode)
                                      //     .update(tempInventory);
                                    } else {
                                      // FirebaseFirestore.instance.collection('Users').doc(_vm.storedetails.storeCode).update{orders: cart);
                                      // FirebaseFirestore.instance.collection("InventoryChanges")
                                      //     .doc(_vm.storedetails.storeCode)
                                      //     .update({
                                      //   productID: quantity
                                      // },
                                      // // SetOptions(merge: true),
                                      // );
                                      //print("no data");
                                    }
                                  }
                                  //print(data);
                                  if (data != null) {
                                    //print("No data found");
                                    //print(productID);
                                    temp[data] = quantity;
                                    tempInventory[data] =
                                        (tempInventory[data] ?? 0) + quantity;

                                    //print(tempInventory);

                                    _ref
                                        .collection("InventoryChanges")
                                        .doc(_vm.storedetails.storeCode)
                                        .update(tempInventory);
                                  } else {
                                    //print(" data found");

                                    FirebaseFirestore.instance
                                        .collection("InventoryChanges")
                                        .doc(_vm.storedetails.storeCode)
                                        .set(
                                      {productID: quantity},
                                      SetOptions(merge: true),
                                    );
                                    // //print(" data found");
                                    // FirebaseFirestore.instance.collection("InventoryChanges")
                                    //     .doc(_vm.storedetails.storeCode)
                                    //     .set({
                                    //   productID: quantity
                                    //
                                    // },
                                    //   SetOptions(merge: true),
                                    // );
                                  }

                                  // //print(productID);
                                  // temp[data] = quantity;
                                  // tempInventory[data] =
                                  //     (tempInventory[data] ?? 0) + quantity;
                                  //
                                  // //print(tempInventory);
                                  //
                                  // _ref
                                  //     .collection("InventoryChanges")
                                  //     .doc(_vm.storedetails.storeCode)
                                  //     .update(tempInventory);
                                  ///old
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()));

                                  // setState(() async {
                                  //   await _vm.updateInventory(tempInventory);
                                  //   //print(tempInventory);
                                  // });
                                }
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final Map inventory;
  final Function(Map inventory) updateInventory;
  final bool isLoading;
  final User user;
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

  //old
  final Map inventoryQuantity;
  final List dispatchList;

  final Function(String product, int quantity, Completer<int> completer)
      updateCart;

  _ViewModel(
    this.inventory,
    this.updateInventory,
    this.isLoading,
    this.user,
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
    this.updateSearch,
    //old
    // this.dispatchList,
    // this.inventoryQuantity,
    //this.storedetails
    this.dispatchList,
    this.inventoryQuantity,
  );

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      store.state.inventoryQuantity,
      (inventory) =>
          store.dispatch(UpdateInventoryQuantity(inventoryQuantity: inventory)),
      store.state.isLoading,
      store.state.currentUser,
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
      (text) => store.dispatch(SearchProduct(text)),
      store.state.dispatchedList,
      store.state.inventoryQuantity,
//             (inventory) => store
//             .dispatch(UpdateInventoryQuantity(inventoryQuantity: inventory)),
    );
  }
}
// class _ViewModel {
//   final List dispatchList;
//   final Map inventoryQuantity;
//   final Function(Map inventory) updateInventory;
//   final StoreDetails storedetails;
//
//   _ViewModel(
//   this.dispatchList, this.inventoryQuantity, this.updateInventory,
//       this.storedetails);
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//         store.state.dispatchedList,
//         store.state.inventoryQuantity,
//             (inventory) => store
//             .dispatch(UpdateInventoryQuantity(inventoryQuantity: inventory)),
//         store.state.storeDetails);
//   }
// }
