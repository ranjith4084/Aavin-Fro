// import 'dart:async';
//
// import 'package:aavinposfro/presentation/screens/home/Home.dart';
// import 'package:aavinposfro/routes.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
//
// import '../../../actions/actions.dart';
// import '../../../actions/auth_actions.dart';
// import '../../../models/PointOfSaleOrderModel.dart';
// import '../../../models/app_state.dart';
// import '../../../models/indent.dart';
// import '../../../models/order.dart';
// import '../../../models/stock.dart';
// import '../../../routes.dart';
// import 'actions/actions.dart';
// import 'actions/auth_actions.dart';
// import 'models/PointOfSaleOrderModel.dart';
// import 'models/indent.dart';
// import 'models/order.dart';
// import 'models/product.dart';
// import 'models/stock.dart';
//
// class KichenProduct extends StatefulWidget {
//   const KichenProduct({Key key}) : super(key: key);
//
//   @override
//   State<KichenProduct> createState() => _KichenProductState();
// }
//
// class _KichenProductState extends State<KichenProduct> {
//   double totalAmount = 0.0;
//   _ViewModel _vm;
//   FirebaseFirestore _ref = FirebaseFirestore.instance;
//   final ref = FirebaseFirestore.instance;
//   List<Varient> listOfVarients = [];
//
//   List<Product1> listOfProducts = [];
//
//   @override
//   void initState() {
//     gatherAllData();
//   }
//
//   gatherAllData() {
//     getDataFromFirestore();
//     getAllProducts();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, _ViewModel>(
//         converter: _ViewModel.fromStore,
//         builder: (context, vm) {
//           this._vm = vm;
//           return Scaffold(
//               appBar: AppBar(
//                 title: Center(child: Text("Kichen Product")),
//                 backgroundColor: Colors.transparent,
//                 elevation: 0.0,
//               ),
//               backgroundColor: Color(0xFF1D8DCF),
//               body: ListView.builder(
//                   itemCount: listOfProducts.length,
//                   itemBuilder: (_, index) {
//                     return Container(
//                       height: 100,
//                       margin: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           listOfProducts[index].productCount != 0
//                               ? Expanded(
//                                   child: IconButton(
//                                     icon: new Icon(Icons.remove),
//                                     onPressed: () async {
//                                       listOfProducts[index].decCount(1);
//                                       controlTotalAmount("-",
//                                           listOfProducts[index].productPrice);
//                                       setState(() {});
//                                     },
//                                   ),
//                                 )
//                               : Expanded(
//                                   child: Container(),
//                                 ),
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                   listOfProducts[index].productName,
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   "₹ ${listOfProducts[index].productPrice}",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 Text(
//                                   " ${listOfProducts[index].productCount}",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: IconButton(
//                               icon: Icon(Icons.add),
//                               onPressed: () async {
//                                 listOfProducts[index].incCount(1);
//                                 controlTotalAmount(
//                                     "+", listOfProducts[index].productPrice);
//                                 setState(() {});
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//               bottomNavigationBar: Container(
//                 color: Color(0xFF1D8DCF),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Row(
//                     children: [
//                       Expanded(
//                           flex: 1,
//                           child: Text('Total Amount',
//                               style: TextStyle(fontSize: 20,color: Colors.white))),
//                       Expanded(
//                           flex: 1,
//                           child: Text("₹ ${totalAmount.toStringAsFixed(2)}",
//                               style: TextStyle(fontSize: 20,color: Colors.white))),
//                       Expanded(
//                         flex: 1,
//                         child: MaterialButton(
//                             height: 40.0,
//                             minWidth: 50.0,
//                             color: Colors.white,
//                             shape: new RoundedRectangleBorder(
//                               borderRadius: new BorderRadius.circular(30.0),
//                             ),
//
//                             onPressed: () async {
//                               for (int i = 0; i < listOfProducts.length; i++) {
//                                 //  this condtions allows only selected products to perform given steps
//                                 if (listOfProducts[i].productCount != 0) {
//                                   bool isAvail =
//                                       checkAllProductVarientsAreAvaliable(
//                                           listOfProducts[i]);
//
//                                   if (isAvail == true) {
//                                     bool avail = isProductQtyAvailable(
//                                         listOfProducts[i]);
//
//                                     if (avail == true) {
//                                       //print("Going to decrese value");
//                                       listOfProducts[i].isStock = true;
//                                       Product1 p = listOfProducts[i];
//
//                                       p.listOfProductVarients
//                                           .forEach((element) {
//                                         double qty = p.productCount.toDouble() *
//                                             element.minusAmount.toDouble();
//                                         //print(
//                                             "minus amount ${element.minusAmount} and user count ${p.productCount}");
//                                         for (int j = 0;
//                                             j < listOfVarients.length;
//                                             j++) {
//                                           if (listOfVarients[j].varientId ==
//                                               element.prodcutVarientId) {
//                                             listOfVarients[j].varientCount -=
//                                                 qty.toInt();
//                                           }
//                                         }
//
//                                         listOfProducts[i].isStock = true;
//                                       });
//                                     } else {
//                                       listOfProducts[i].isStock = false;
//                                     }
//                                   } else {
//                                     listOfProducts[i].isStock = false;
//                                   }
//                                 }
//                               }
//
//                               // checking out of products to show dialoglog list
//
//                               List<Product1> stockProducts = [];
//                               List<Product1> outOfStockProducts = [];
//
//                               listOfProducts.forEach((element) {
//                                 if (element.productCount > 0) {
//                                   if (element.isStock) {
//                                     stockProducts.add(element);
//                                   } else {
//                                     outOfStockProducts.add(element);
//                                   }
//                                 }
//                               });
//
//                               if (outOfStockProducts.length == 0) {
//                                 // push to firebase
//
//                                 Map<String, double> firebaseDoc = {};
//
//                                 listOfVarients.forEach((element) {
//                                   firebaseDoc[element.varientId.toString()] =
//                                       element.varientCount.toDouble();
//                                 });
//
//                                 // await ref
//                                 //     .collection("InventoryChanges")
//                                 //     .doc("P167")
//                                 //     .update(firebaseDoc)
//                                 //     .whenComplete(() {
//                                 //   //print("************ 200 completed **************");
//                                 // });
//
//                                 await _ref
//                                     .collection("InventoryChanges")
//                                     .doc(_vm.storedetails.storeCode)
//                                     .update(firebaseDoc)
//                                     .whenComplete(() {
//                                   //print(
//                                       "************ 400 completed **************");
//                                 });
//                                 setState(() {
//                                   _vm.updateInventory(firebaseDoc);
//                                 });
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => HomePage()));
//                               } else {
//                                 //print(
//                                     "outofstock product ${listOfProducts[0].productName} ");
//                                 outOfStockProducts.forEach((element) async {
//                                   //print(
//                                       "List of  product ${element.productName} ");
//                                 });
//                                 await showDialog(
//                                   context: context,
//                                   builder: (_) => AlertDialog(
//                                     title: Center(
//                                       child: Text(
//                                           "No SubProduct is available for "),
//                                     ),
//                                     content: SizedBox(
//                                       width: double.maxFinite,
//                                       //  <------- Use SizedBox to limit width
//                                       child: ListView.builder(
//                                         shrinkWrap: true,
//                                         //            <------  USE SHRINK WRAP
//                                         itemCount: outOfStockProducts.length,
//                                         itemBuilder: (context, index) => Center(
//                                             child: Text(
//                                                 outOfStockProducts[index]
//                                                     .productName)),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//
//                                 // show the dialog
//                                 // reset all values or refresh screen
//
//                                 //print("entered false condition");
//                                 setState(() {});
//                               }
//
//                               //print(
//                                   "Stock product count${stockProducts.length} and outofstock product count${outOfStockProducts.length} ");
//
//                               // tap funtion end here
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 6),
//                               child: Text(
//                                 'Done',
//                                 style: TextStyle(color: Colors.black,fontSize: 16),
//                               ),
//                             )),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//               // Container(
//               //   height: 70,
//               //   color:Color(0xFF1D8DCF),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //     children: [
//               //       Row(
//               //         children: [
//               //           Text("Total Amount     "),
//               //           Text("${totalAmount} rs"),
//               //         ],
//               //       ),
//               //       InkWell(
//               //         onTap: () async {
//               //           for (int i = 0; i < listOfProducts.length; i++) {
//               //             //  this condtions allows only selected products to perform given steps
//               //             if (listOfProducts[i].productCount != 0) {
//               //               bool isAvail =
//               //                   checkAllProductVarientsAreAvaliable(listOfProducts[i]);
//               //
//               //               if (isAvail == true) {
//               //                 bool avail = isProductQtyAvailable(listOfProducts[i]);
//               //
//               //                 if (avail == true) {
//               //                   //print("Going to decrese value");
//               //                   listOfProducts[i].isStock = true;
//               //                   Product p = listOfProducts[i];
//               //
//               //                   p.listOfProductVarients.forEach((element) {
//               //                     double qty = p.productCount.toDouble() *
//               //                         element.minusAmount.toDouble();
//               //                     //print(
//               //                         "minus amount ${element.minusAmount} and user count ${p.productCount}");
//               //                     for (int j = 0; j < listOfVarients.length; j++) {
//               //                       if (listOfVarients[j].varientId ==
//               //                           element.prodcutVarientId) {
//               //                         listOfVarients[j].varientCount -= qty.toInt();
//               //                       }
//               //                     }
//               //
//               //                     listOfProducts[i].isStock = true;
//               //                   });
//               //                 } else {
//               //                   listOfProducts[i].isStock = false;
//               //                 }
//               //               } else {
//               //                 listOfProducts[i].isStock = false;
//               //               }
//               //             }
//               //           }
//               //
//               //           // checking out of products to show dialoglog list
//               //
//               //           List<Product> stockProducts = [];
//               //           List<Product> outOfStockProducts = [];
//               //
//               //           listOfProducts.forEach((element) {
//               //             if (element.productCount > 0) {
//               //               if (element.isStock) {
//               //                 stockProducts.add(element);
//               //               } else {
//               //                 outOfStockProducts.add(element);
//               //               }
//               //             }
//               //           });
//               //
//               //           if (outOfStockProducts.length == 0) {
//               //             // push to firebase
//               //
//               //             Map<String, double> firebaseDoc = {};
//               //
//               //             listOfVarients.forEach((element) {
//               //               firebaseDoc[element.varientId.toString()] =
//               //                   element.varientCount.toDouble();
//               //             });
//               //
//               //             await ref
//               //                 .collection("InventoryChanges")
//               //                 .doc("P167")
//               //                 .update(firebaseDoc)
//               //                 .whenComplete(() {
//               //               //print("************ 200 completed **************");
//               //             });
//               //           } else {
//               //             // show the dialog
//               //             // reset all values or refresh screen
//               //
//               //             //print("entered false condition");
//               //             setState(() {});
//               //           }
//               //
//               //           //print(
//               //               "Stock product count${stockProducts.length} and outofstock product count${outOfStockProducts.length} ");
//               //
//               //           // tap funtion end here
//               //         },
//               //         child: Container(
//               //           width: 100,
//               //           height: 45,
//               //           color: Colors.blue,
//               //           alignment: Alignment.center,
//               //           child: Text(
//               //             "Done",
//               //             style: TextStyle(color: Colors.white),
//               //           ),
//               //         ),
//               //       )
//               //     ],
//               //   ),
//               // ),
//               );
//         });
//   }
//
//   // it checks the user quality with invertorychanges stock
//   bool isProductQtyAvailable(Product1 product) {
//     bool stackAvailable = false;
//
//     product.listOfProductVarients.forEach((element) {
//       double totalQty =
//           product.productCount.toDouble() * element.minusAmount.toDouble();
//
//       listOfVarients.forEach((ele) {
//         if (ele.varientId == element.prodcutVarientId) {
//           if (ele.varientCount > totalQty) {
//             stackAvailable = true;
//           } else {
//             stackAvailable = false;
//           }
//         }
//       });
//     });
//
//     return stackAvailable;
//   }
//
//   // this funtion retruns true if the all varients of the prodcut is avail
//   bool checkAllProductVarientsAreAvaliable(Product1 product) {
//     int productsVarientCount = product.listOfProductVarients.length;
//
//     int matchedCount = 0;
//
//     for (int i = 0; i < product.listOfProductVarients.length; i++) {
//       String productId = product.listOfProductVarients[i].prodcutVarientId;
//
//       listOfVarients.forEach((element) {
//         if (element.varientId == productId) {
//           matchedCount++;
//         }
//       });
//     }
//
//     return productsVarientCount == matchedCount;
//   }
//
// // this funtion controls the total amount
//   controlTotalAmount(String symbol, double amount) {
//     switch (symbol) {
//       case "+":
//         totalAmount += amount;
//         break;
//
//       case "-":
//         if (totalAmount <= 0) return;
//         totalAmount -= amount;
//     }
//
//     setState(() {});
//   }
//
//   // this funtion fetch data inventroy changes collection in firebase
//   getDataFromFirestore() async {
//     DocumentSnapshot documentSnapshot =
//         await ref.collection("InventoryChanges").doc("P167").get();
//     Map d = documentSnapshot.data() as Map;
//
//     d.keys.forEach((element) {
//       listOfVarients.add(Varient(element.toString(), d[element].toDouble()));
//     });
//     setState(() {});
//   }
//
//   // this funtion fetch data Kitchen Product collection in firebase
//   getAllProducts() async {
//     QuerySnapshot querySnapshot = await ref.collection("KitchenProduct").get();
//     List<DocumentSnapshot> listOfDocsSnap = querySnapshot.docs;
//     listOfDocsSnap.forEach((element) {
//       Product1 product = Product1();
//       product.productName = element["ProductName"];
//       product.productId = element["ProductID"];
//
//       product.productPrice = element["price"];
//
//       List<dynamic> data = element["data"];
//       data.forEach((ele) {
//         ProductVarient productVariety =
//             ProductVarient(ele["Qty"], ele["SubProductID"].toString());
//         product.listOfProductVarients.add(productVariety);
//       });
//
//       listOfProducts.add(product);
//     });
//     setState(() {});
//   }
// }
//
// // inventory changes model class
// class Varient {
//   String varientId;
//   double varientCount = 0;
//
//   Varient(id, value) {
//     this.varientId = id;
//     this.varientCount = value;
//   }
//
//   @override
//   String toString() {
//     return "tha varientId is ${varientId} and totalQtyinStock ${varientCount}";
//   }
// }
//
// // kicthenproduct model class
// class Product1 {
//   String productName;
//   String productId;
//   double productPrice = 0.0;
//   bool isStock = true;
//
//   int productCount = 0;
//   List<ProductVarient> listOfProductVarients = [];
//
//   void incCount(int value) {
//     productCount += value;
//   }
//
//   void decCount(int value) {
//     if (productCount <= 0) return;
//     productCount -= value;
//   }
// }
//
// class ProductVarient<T> {
//   T minusAmount;
//
//   String prodcutVarientId;
//
//   ProductVarient(this.minusAmount, this.prodcutVarientId);
// }
//
// class _ViewModel {
//   final Map inventory;
//   final Function(Map inventory) updateInventory;
//   final bool isLoading;
//   final User user;
//   final Order order;
//   final Stock stock;
//   final Cart cart;
//   final int phoneNumber;
//   final Function() checkout;
//   final Function(String route) navigation;
//   final Function() initStockEdit;
//   final Function() signOut;
//   final Function() orderhistory;
//   final Function(PointOfSaleOrder pos) updatePos;
//   final Function() resetOrder;
//   final Function(String text) updateSearch;
//   final StoreDetails storedetails;
//
//   //old
//   final Map inventoryQuantity;
//   final List dispatchList;
//
//   final Function(String product, int quantity, Completer<int> completer)
//       updateCart;
//
//   _ViewModel(
//     this.inventory,
//     this.updateInventory,
//     this.isLoading,
//     this.user,
//     this.order,
//     this.stock,
//     this.cart,
//     this.checkout,
//     this.initStockEdit,
//     this.signOut,
//     this.phoneNumber,
//     this.orderhistory,
//     this.resetOrder,
//     this.storedetails,
//     this.updateCart,
//     this.updatePos,
//     this.navigation,
//     this.updateSearch,
//     //old
//     // this.dispatchList,
//     // this.inventoryQuantity,
//     //this.storedetails
//     this.dispatchList,
//     this.inventoryQuantity,
//   );
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//       store.state.inventoryQuantity,
//       (inventory) =>
//           store.dispatch(UpdateInventoryQuantity(inventoryQuantity: inventory)),
//       store.state.isLoading,
//       store.state.currentUser,
//       store.state.order,
//       store.state.stock,
//
//       store.state.cart,
//       () => store.dispatch(NavigateAction(AppRoutes.checkout)),
//       () => store.dispatch(InitStockEditAction()),
//       () => store.dispatch(AuthSignOutAction()),
//       store.state.phoneNumber,
//       () => store.dispatch(NavigateAction(AppRoutes.orderhistory)),
//       () => store.dispatch(ResetOrder("Success")),
//       store.state.storeDetails,
//       (product, quantity, completer) =>
//           store.dispatch(UpdateCartAction(product, quantity, completer)),
//       (posorderModel) => store.dispatch(UpdatePosSale(posorderModel)),
//       (route) => store.dispatch(NavigateAction(route)),
//
//       (text) => store.dispatch(SearchProduct(text)),
//       store.state.dispatchedList,
//       store.state.inventoryQuantity,
// //             (inventory) => store
// //             .dispatch(UpdateInventoryQuantity(inventoryQuantity: inventory)),
//     );
//   }
// }
