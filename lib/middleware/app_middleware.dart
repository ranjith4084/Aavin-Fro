// import 'dart:async';
// import 'dart:convert';
// import 'package:aavinposfro/actions/actions.dart';
// import 'package:aavinposfro/actions/auth_actions.dart';
// import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
// import 'package:aavinposfro/models/app_state.dart';
// import 'package:aavinposfro/models/indent_order.dart';
// import 'package:aavinposfro/models/product.dart';
// import 'package:aavinposfro/routes.dart';
// import 'package:aavinposfro/utils/ResponseMessage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:redux/redux.dart';
// String LoginId;
// var docu;
// var storeID;
// var data;
// var storeCode;
// var parlourId;
// var regionID;
// var zoneID;
// var storeAddress;
// var contactPerson;
// final FirebaseAuth _auth = FirebaseAuth.instance;
// StreamSubscription<QuerySnapshot> snapshot;
//
// appMiddleware(Store<AppState> store, action, NextDispatcher next) async {
//   print("23456werty");
//   if (action is InitAppAction) {
//     print("qwertyuklkjhgfdfghjklkjhgfdghjkjhgf");
//     await Firebase.initializeApp();
//     print("2345678");
//     _auth.authStateChanges().listen((firebaseUser) {
//       print("7890-");
//       if (firebaseUser != null) {
//         print("LoginId");
//         String phoneNumber = firebaseUser.email;
//         final user = FirebaseAuth.instance.currentUser;
//         print("+11111+++++${user.email}");
//         user.email.substring(0,4);
//         LoginId= user.email.substring(0,4).toUpperCase();
//         // //print("The Login Id - ${LoginId}");
//         // store.dispatch(UpdatePhoneNumber(int.parse(phoneNumber.substring(3))));
//         store.dispatch(FetchStoreDetails());
//       } else {
//         store.dispatch(ShowLoadingAction(true));
//         if (store.state.currentRoute != AppRoutes.login) {
//           store.dispatch(NavigateAction(AppRoutes.login));
//         }
//       }
//       store.dispatch(AuthStateChangeAction(firebaseUser));
//     });
//   } else if (action is AuthSignOutAction) {
//     print("sdfghjkl");
//     _auth
//         .signOut()
//         .then((value) => store.dispatch(AuthStateChangeAction(null)));
//   } else if (action is FetchProductsAction)
//   {
//
//
//     print(
//         "Entering fetch $LoginId  sfgyushb  $parlourId");
//     var dataFromApi;
// //live api
// //     //print("000000 The Username  - $LoginId and parlour id - $parlourId 0000000");
// if(LoginId=="P171"||LoginId=="P168"){
//   //||LoginId=="P168"
//   print(
//       "Entering inside fetch $LoginId  sfgyushb  $parlourId");
//   print(
//       "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=${LoginId}_PM&password=Aavin123&tenantId=aavin-fed&parlourId=$parlourId");
//    dataFromApi = await http.read(Uri.parse(
//       "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=${LoginId}_PM&password=Aavin123&tenantId=aavin-fed&parlourId=$parlourId"));
// }
// else{
//   print(
//       "Entering outside  fetch $LoginId  sfgyushb  $parlourId");
//    dataFromApi = await http.read(Uri.parse(
//       "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=P167&password=Aavin123&tenantId=aavin-fed&parlourId=P167_PM"));
// }
//     // var dataFromApi = await http.read(Uri.parse(
//     //     "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=$LoginId&password=Aavin123&tenantId=aavin-fed&parlourId=$parlourId"));
//     https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=P165&password=Aavin123&tenantId=aavin-fed&parlourId=P165_PM
//     // //print("catalog  ${dataFromApi}");
//
//
//     var products = <Product>[];
//     var products1 = <Product1>[];
//
//
//     ///productCatalog
//     if (jsonDecode(dataFromApi)["productCatalog"] != null) {
//       jsonDecode(dataFromApi)["productCatalog"].forEach((data) {
//         products.add(
//           Product(
//               data["productId"],
//               data["productName"],
//               "125g",
//               data["totalPrice"].toDouble(),
//               data['cgstAmount'].toDouble() + data['sgstAmount'].toDouble(),
//               0.0,
//               data['cgstAmount'].toDouble(),
//               data['sgstAmount'].toDouble(),
//               true,
//               data['basicPrice'].toDouble(),
//               0,
//               '',
//               data["productId"],
//               ""),
//         );
//       });
//     }
//     ////kitchenProductCatalog---rawMaterialsCatalog
//     if (jsonDecode(dataFromApi)["kitchenProductCatalog"][0]
//             ["rawMaterialsCatalog"] !=
//         null) {
//       jsonDecode(dataFromApi)["kitchenProductCatalog"][0]["rawMaterialsCatalog"]
//           .forEach((data) {
//         products.add(Product(
//             data["productId"],
//             data["productName"],
//             "125g",
//             data["totalPrice"],
//             data['cgstAmount'],
//             0.0,
//             data['cgstAmount'],
//             data['sgstAmount'],
//             true,
//             data['basicPrice'],
//             0,
//             '',
//             data["productId"],
//             ""));
//       });
//     }
//     ////kitchenProductCatalog---finishedProdCatalog
//     if (jsonDecode(dataFromApi)["kitchenProductCatalog"][0]
//             ["finishedProdCatalog"] !=
//         null) {
//       jsonDecode(dataFromApi)["kitchenProductCatalog"][0]["finishedProdCatalog"]
//           .forEach((data) {
//         products.add(
//           Product(
//               data["productId"],
//               data["productName"],
//               "125g",
//               data["totalPrice"].toDouble(),
//               data['cgstAmount'].toDouble() + data['sgstAmount'].toDouble(),
//               0.0,
//               data['cgstAmount'].toDouble(),
//               data['sgstAmount'].toDouble(),
//               true,
//               data['basicPrice'].toDouble(),
//               0,
//               '',
//               data["productId"],
//               ""),
//         );
//       });
//     }
//
//     store.dispatch(UpdateProductsAction(products));
//     // //print("4445556667778899900${UpdateProductsAction(products)}");
//   } else if (action is PlaceOrderAction) {
//     store.dispatch(ShowLoadingAction(true));
//     await FirebaseFirestore.instance
//         .collection("Indent_Order")
//         .add(action.order.toMap())
//         .catchError((onError) {
//       store.dispatch(ResetOrder(onError.toString()));
//     }).then((value) {
//       debugPrint("reset2 middle");
//       store.dispatch(ResetOrder(ResponseMessage.success));
//       //  store.dispatch(ShowLoadingAction(false));
//     });
//   } else if (action is FetchStoreDetails) {
//
//     print("LoginId");
//     var storeSnapShot = await FirebaseFirestore.instance
//         .collection("Pos_login")
//
//         .where("StoreCode", isEqualTo: "P099")
//         .get();
//
//     if (storeSnapShot.docs.length > 0) {
//
//
//        storeID = storeSnapShot.docs[0].id;
//        data = storeSnapShot.docs[0].data();
//        storeCode = data['StoreCode'];
//        parlourId = data['parlourId'];
//        regionID = data['Ref_Region_Id'];
//        zoneID = data['Ref_Zone_Id'];
//        storeAddress = data['StoreAddress'];
//        contactPerson = data['StoreContactPerson'];
//       store.dispatch(StoreDetails(
//           storeID,parlourId, storeCode, regionID, zoneID, storeAddress, contactPerson));
//
//       store.dispatch(NavigationClearAllPages(AppRoutes.home));
//
//       store.dispatch(new FetchIndentOrder());
//        print("hgfygujhbvfyguhjkbhvfyughkjbvguhkjbhjvgutiyhkjbjuihkjbhgiuh ${store.state.storeDetails.storeCode}");
//       Map<String, dynamic> inventorySnapShot = (
//           await FirebaseFirestore.instance
//               .collection("InventoryChanges")
//               // .doc(store.state.storeDetails.storeCode)
//               .doc(store.state.storeDetails.storeCode)
//               .get())
//           .data();
// print("ftugjhgtruhgtyr6tuihjfyrutiuh ${store.state.storeDetails.storeCode}");
//       store.dispatch(
//           UpdateInventoryQuantity(inventoryQuantity: inventorySnapShot));
//        store.dispatch(FetchProductsAction());
//       //store.dispatch(action)
//     }
//   } else if (action is FetchIndentOrder) {
//     store.dispatch(ShowLoadingAction(true));
//     snapshot = FirebaseFirestore.instance
//         .collection("Indent_Order")
//         .where("Store_ID", isEqualTo: store.state.storeDetails.storeDocumentID)
//         .orderBy('Updated_At', descending: true)
//         .snapshots()
//         .listen((event) {
//       if (event.docs.length > 0) {
//         var indentlist = <IndentOrder>[];
//         event.docs.forEach((doc) {
//           var data = doc.data();
//           IndentOrder indentOrder = IndentOrder.fromJson(data);
//           indentOrder.docID = doc.id;
//           indentlist.add(indentOrder);
//         });
//
//         store.dispatch(UpdateOrderHistory(new List<IndentOrder>()));
//         store.dispatch(UpdateOrderHistory(indentlist));
//       }
//     });
//   }
//
//   else if (action is UpdatePosSale) {
//     store.dispatch(ShowLoadingAction(true));
//
//     await FirebaseFirestore.instance
//         .collection("POS_Order")
//         .add(action.pointOfSaleOrder.toUpdateMap())
//         .then(
//       (value) async {
//         await FirebaseFirestore.instance
//             .collection('POS_Order')
//             .doc(value.id)
//             .update({"Document_Id": value.id});
//
//         // //print(value.id);
//         docu = "${value.id}";
//         // //print("+++++++++++++${docu}");
//         // ignore: unnecessary_statements
//
//         return docu;
//       },
//
//     );
//     store.dispatch(ResetOrder(""));
//     store.dispatch(ShowLoadingAction(false));
//     return true;
//   } else if (action is FetchOrder) {
//     try {
//       String storeID = store.state.storeDetails.storeDocumentID;
//       var productsSnapshot = await FirebaseFirestore.instance
//           .collection("POS_Order")
//           .where("Store_ID", isEqualTo: storeID)
//           .get();
//       var pointOfSale = <PointOfSaleOrder>[];
//       productsSnapshot.docs.forEach((doc) {
//         var data = doc.data();
//         PointOfSaleOrder pointOfSaleOrder = PointOfSaleOrder.fromJson(data);
//         pointOfSale.add(pointOfSaleOrder);
//
//       });
//
//       store.dispatch(UpdateOrder(pointOfSale));
//       store.dispatch(ShowLoadingAction(false));
//     } catch (ex) {
//       //print(ex.toString());
//     }
//   } else if (action is SearchProduct) {
//     List<Product> list;
//     if (action.searchText != "") {
//       list = store.state.products
//           .where((products) => (products.id
//                   .toLowerCase()
//                   .contains(action.searchText.toLowerCase()) ||
//               products.name
//                   .toLowerCase()
//                   .contains(action.searchText.toLowerCase())))
//           .toList();
//     } else {
//       list = null;
//     }
//     store.dispatch(UpdateSearchProduct(list));
//   }
// print("srdtfyguhijko");
//   next(action);
// }
// // import 'dart:async';
// // import 'dart:convert';
// //
// // import 'package:aavinposfro/actions/actions.dart';
// // import 'package:aavinposfro/actions/auth_actions.dart';
// // import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
// // import 'package:aavinposfro/models/app_state.dart';
// // import 'package:aavinposfro/models/indent_order.dart';
// // import 'package:aavinposfro/models/product.dart';
// // import 'package:aavinposfro/routes.dart';
// // import 'package:aavinposfro/utils/ResponseMessage.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:redux/redux.dart';
// //
// // String LoginId;
// // var docu;
// // var storeID;
// // var data;
// // var storeCode;
// // var parlourId;
// // var regionID;
// // var zoneID;
// // var storeAddress;
// // var contactPerson;
// // final FirebaseAuth _auth = FirebaseAuth.instance;
// // StreamSubscription<QuerySnapshot> snapshot;
// //
// // appMiddleware(Store<AppState> store, action, NextDispatcher next) async {
// //   print("23456werty");
// //   if (action is InitAppAction) {
// //     print("qwertyuklkjhgfdfghjklkjhgfdghjkjhgf");
// //     await Firebase.initializeApp();
// //     print("2345678");
// //     _auth.authStateChanges().listen((firebaseUser) {
// //       print("7890-");
// //       if (firebaseUser != null) {
// //         print("LoginId");
// //         String phoneNumber = firebaseUser.email;
// //         final user = FirebaseAuth.instance.currentUser;
// //         print("+11111+++++${user.email}");
// //         user.email.substring(0, 4);
// //         LoginId = user.email.substring(0, 4).toUpperCase();
// //         // //print("The Login Id - ${LoginId}");
// //         // store.dispatch(UpdatePhoneNumber(int.parse(phoneNumber.substring(3))));
// //         store.dispatch(FetchStoreDetails());
// //       } else {
// //         store.dispatch(ShowLoadingAction(true));
// //         if (store.state.currentRoute != AppRoutes.login) {
// //           store.dispatch(NavigateAction(AppRoutes.login));
// //         }
// //       }
// //       store.dispatch(AuthStateChangeAction(firebaseUser));
// //     });
// //   } else if (action is AuthSignOutAction) {
// //     print("sdfghjkl");
// //     _auth
// //         .signOut()
// //         .then((value) => store.dispatch(AuthStateChangeAction(null)));
// //   } else if (action is FetchProductsAction) {
// //     print("Entering fetch $LoginId  sfgyushb  $parlourId");
// //     var dataFromApi;
// // //live api
// // //     //print("000000 The Username  - $LoginId and parlour id - $parlourId 0000000");
// //     if (LoginId == "P171" || LoginId == "P168") {
// //       //||LoginId=="P168"
// //       print("Entering inside fetch $LoginId  sfgyushb  $parlourId");
// //       print(
// //           "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=${LoginId}_PM&password=Aavin123&tenantId=aavin-fed&parlourId=$parlourId");
// //       dataFromApi = await http.read(Uri.parse(
// //           "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=${LoginId}_PM&password=Aavin123&tenantId=aavin-fed&parlourId=$parlourId"));
// //     } else {
// //       print("Entering outside  fetch $LoginId  sfgyushb  $parlourId");
// //       dataFromApi = await http.read(Uri.parse(
// //           "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=P167&password=Aavin123&tenantId=aavin-fed&parlourId=P167_PM"));
// //     }
// //     // var dataFromApi = await http.read(Uri.parse(
// //     //     "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=$LoginId&password=Aavin123&tenantId=aavin-fed&parlourId=$parlourId"));
// //     https: //idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=P165&password=Aavin123&tenantId=aavin-fed&parlourId=P165_PM
// //     // //print("catalog  ${dataFromApi}");
// //
// //     var products = <Product>[];
// //     var products1 = <Product1>[];
// //
// //     ///productCatalog
// //     if (jsonDecode(dataFromApi)["productCatalog"] != null) {
// //       jsonDecode(dataFromApi)["productCatalog"].forEach((data) {
// //         products.add(
// //           Product(
// //               data["productId"],
// //               data["productName"],
// //               "125g",
// //               data["totalPrice"].toDouble(),
// //               data['cgstAmount'].toDouble() + data['sgstAmount'].toDouble(),
// //               0.0,
// //               data['cgstAmount'].toDouble(),
// //               data['sgstAmount'].toDouble(),
// //               true,
// //               data['basicPrice'].toDouble(),
// //               0,
// //               '',
// //               data["productId"],
// //               ""),
// //         );
// //       });
// //     }
// //     ////kitchenProductCatalog---rawMaterialsCatalog
// //     if (jsonDecode(dataFromApi)["kitchenProductCatalog"][0]
// //     ["rawMaterialsCatalog"] !=
// //         null) {
// //       jsonDecode(dataFromApi)["kitchenProductCatalog"][0]["rawMaterialsCatalog"]
// //           .forEach((data) {
// //         products.add(Product(
// //             data["productId"],
// //             data["productName"],
// //             "125g",
// //             data["totalPrice"],
// //             data['cgstAmount'],
// //             0.0,
// //             data['cgstAmount'],
// //             data['sgstAmount'],
// //             true,
// //             data['basicPrice'],
// //             0,
// //             '',
// //             data["productId"],
// //             ""));
// //       });
// //     }
// //     ////kitchenProductCatalog---finishedProdCatalog
// //     if (jsonDecode(dataFromApi)["kitchenProductCatalog"][0]
// //     ["finishedProdCatalog"] !=
// //         null) {
// //       jsonDecode(dataFromApi)["kitchenProductCatalog"][0]["finishedProdCatalog"]
// //           .forEach((data) {
// //         products.add(
// //           Product(
// //               data["productId"],
// //               data["productName"],
// //               "125g",
// //               data["totalPrice"].toDouble(),
// //               data['cgstAmount'].toDouble() + data['sgstAmount'].toDouble(),
// //               0.0,
// //               data['cgstAmount'].toDouble(),
// //               data['sgstAmount'].toDouble(),
// //               true,
// //               data['basicPrice'].toDouble(),
// //               0,
// //               '',
// //               data["productId"],
// //               ""),
// //         );
// //       });
// //     }
// //
// //     store.dispatch(UpdateProductsAction(products));
// //     // //print("4445556667778899900${UpdateProductsAction(products)}");
// //   } else if (action is PlaceOrderAction) {
// //     store.dispatch(ShowLoadingAction(true));
// //     await FirebaseFirestore.instance
// //         .collection("Indent_Order")
// //         .add(action.order.toMap())
// //         .catchError((onError) {
// //       store.dispatch(ResetOrder(onError.toString()));
// //     }).then((value) {
// //       debugPrint("reset2 middle");
// //       store.dispatch(ResetOrder(ResponseMessage.success));
// //       //  store.dispatch(ShowLoadingAction(false));
// //     });
// //   } else if (action is FetchStoreDetails) {
// //     print("LoginId");
// //     var storeSnapShot = await FirebaseFirestore.instance
// //         .collection("Pos_login")
// //         .where("StoreCode", isEqualTo: "P099")
// //         .get();
// //
// //     if (storeSnapShot.docs.length > 0) {
// //       storeID = storeSnapShot.docs[0].id;
// //       data = storeSnapShot.docs[0].data();
// //       storeCode = data['StoreCode'];
// //       parlourId = data['parlourId'];
// //       regionID = data['Ref_Region_Id'];
// //       zoneID = data['Ref_Zone_Id'];
// //       storeAddress = data['StoreAddress'];
// //       contactPerson = data['StoreContactPerson'];
// //       store.dispatch(StoreDetails(storeID, parlourId, storeCode, regionID,
// //           zoneID, storeAddress, contactPerson));
// //
// //       store.dispatch(NavigationClearAllPages(AppRoutes.home));
// //
// //       store.dispatch(new FetchIndentOrder());
// //       print(
// //           "hgfygujhbvfyguhjkbhvfyughkjbvguhkjbhjvgutiyhkjbjuihkjbhgiuh ${store.state.storeDetails.storeCode}");
// //       Map<String, dynamic> inventorySnapShot = (await FirebaseFirestore.instance
// //           .collection("InventoryChanges")
// //       // .doc(store.state.storeDetails.storeCode)
// //           .doc(store.state.storeDetails.storeCode)
// //           .get())
// //           .data();
// //       print(
// //           "ftugjhgtruhgtyr6tuihjfyrutiuh ${store.state.storeDetails.storeCode}");
// //       store.dispatch(
// //           UpdateInventoryQuantity(inventoryQuantity: inventorySnapShot));
// //       // store.dispatch(FetchProductsAction());
// //       //store.dispatch(action)
// //     }
// //   } else if (action is FetchIndentOrder) {
// //     store.dispatch(ShowLoadingAction(true));
// //     snapshot = FirebaseFirestore.instance
// //         .collection("Indent_Order")
// //         .where("Store_ID", isEqualTo: store.state.storeDetails.storeDocumentID)
// //         .orderBy('Updated_At', descending: true)
// //         .snapshots()
// //         .listen((event) {
// //       if (event.docs.length > 0) {
// //         var indentlist = <IndentOrder>[];
// //         event.docs.forEach((doc) {
// //           var data = doc.data();
// //           IndentOrder indentOrder = IndentOrder.fromJson(data);
// //           indentOrder.docID = doc.id;
// //           indentlist.add(indentOrder);
// //         });
// //
// //         store.dispatch(UpdateOrderHistory(new List<IndentOrder>()));
// //         store.dispatch(UpdateOrderHistory(indentlist));
// //       }
// //     });
// //   } else if (action is UpdatePosSale) {
// //     store.dispatch(ShowLoadingAction(true));
// //
// //     // await FirebaseFirestore.instance
// //     //     .collection("POS_Order")
// //     //     .add(action.pointOfSaleOrder.toUpdateMap())
// //     //     .catchError((e) {
// //     //   return false;
// //     // });
// //     await FirebaseFirestore.instance
// //         .collection("POS_Order")
// //         .add(action.pointOfSaleOrder.toUpdateMap())
// //         .then(
// //           (value) async {
// //         await FirebaseFirestore.instance
// //             .collection('POS_Order')
// //             .doc(value.id)
// //             .update({"Document_Id": value.id});
// //
// //         // //print(value.id);
// //         docu = "${value.id}";
// //         // //print("+++++++++++++${docu}");
// //         // ignore: unnecessary_statements
// //
// //         return docu;
// //       },
// //     );
// //     store.dispatch(ResetOrder(""));
// //     store.dispatch(ShowLoadingAction(false));
// //     return true;
// //   } else if (action is FetchOrder) {
// //     try {
// //       String storeID = store.state.storeDetails.storeDocumentID;
// //       var productsSnapshot = await FirebaseFirestore.instance
// //           .collection("POS_Order")
// //           .where("Store_ID", isEqualTo: storeID)
// //           .get();
// //       var pointOfSale = <PointOfSaleOrder>[];
// //       productsSnapshot.docs.forEach((doc) {
// //         var data = doc.data();
// //         PointOfSaleOrder pointOfSaleOrder = PointOfSaleOrder.fromJson(data);
// //         pointOfSale.add(pointOfSaleOrder);
// //       });
// //
// //       store.dispatch(UpdateOrder(pointOfSale));
// //       store.dispatch(ShowLoadingAction(false));
// //     } catch (ex) {
// //       //print(ex.toString());
// //     }
// //   } else if (action is SearchProduct) {
// //     List<Product> list;
// //     if (action.searchText != "") {
// //       list = store.state.products
// //           .where((products) => (products.id
// //           .toLowerCase()
// //           .contains(action.searchText.toLowerCase()) ||
// //           products.name
// //               .toLowerCase()
// //               .contains(action.searchText.toLowerCase())))
// //           .toList();
// //     } else {
// //       list = null;
// //     }
// //     store.dispatch(UpdateSearchProduct(list));
// //   }
// //   print("srdtfyguhijko");
// //   next(action);
// // }
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/routes.dart';
import 'package:aavinposfro/sharedpreference.dart';
import 'package:aavinposfro/utils/ResponseMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
String LoginId;
var parlourId;
var storeID;
var data ;
var storeCode ;
var regionID  ;
var zoneID ;
var storeAddress;
var contactPerson;
final FirebaseAuth _auth = FirebaseAuth.instance;
StreamSubscription<QuerySnapshot> snapshot;

appMiddleware(Store<AppState> store, action, NextDispatcher next) async {

      if (action is InitAppAction) {
    print("qwertyuklkjhgfdfghjklkjhgfdghjkjhgf");
    await Firebase.initializeApp();
    print("2345678");
    _auth.authStateChanges().listen((firebaseUser) {
      print("7890-");
      if (firebaseUser == null) {
        print("LoginId");
        // String phoneNumber = firebaseUser.email;
        // final user = FirebaseAuth.instance.currentUser;
        // print("+11111+++++${user.email}");
        // user.email.substring(0,4);
        // LoginId= user.email.substring(0,4).toUpperCase();
        // //print("The Login Id - ${LoginId}");
        // store.dispatch(UpdatePhoneNumber(int.parse(phoneNumber.substring(3))));
        store.dispatch(FetchStoreDetails());
      } else {
        store.dispatch(ShowLoadingAction(true));
        if (store.state.currentRoute != AppRoutes.login) {
          store.dispatch(NavigateAction(AppRoutes.login));
        }
      }
      store.dispatch(AuthStateChangeAction(firebaseUser));
    });
  } else if (action is AuthSignOutAction) {
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++222222222222222222222222");
    _auth
        .signOut()
        .then((value) => store.dispatch(AuthStateChangeAction(null)));
  } else if (action is FetchProductsAction) {
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++33333333333333333333333");
    print(
        "Entering fetch"); //https://10.236.234.100:22443/rest/posApi/fetchProductCatalog?username=P167&password=Aavin123&tenantId=AAVIN-LATEST&parlourId=P167_PM
    var dataFromApi = await http.read(Uri.parse(
        "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchProductCatalog?username=P999_PM&password=Aavin123&tenantId=aavin-fed&parlourId=P999_PM"));
    print("catalog  ${dataFromApi}");
    // var productsSnapshot = await FirebaseFirestore.instance
    //     .collection("IDMS_Product")
    //     .where("Is_Active", isEqualTo: true)
    //     .get();
    // print("product testing${productsSnapshot}");
    var products = <Product>[];
    if (jsonDecode(dataFromApi)["productCatalog"] != null) {
      jsonDecode(dataFromApi)["productCatalog"].forEach((data) {
        products.add(Product(
            data["productId"],
            data["productName"],
            "125g",
            data["totalPrice"].toDouble(),
            data['cgstAmount'].toDouble() + data['sgstAmount'].toDouble(),
            0.0,
            data['cgstAmount'].toDouble(),
            data['sgstAmount'].toDouble(),
            true,
            data['basicPrice'].toDouble(),
            0,
            '',
            data["productId"],
            ""));
      });
    }

    store.dispatch(UpdateProductsAction(products));
  } else if (action is PlaceOrderAction) {
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++55555555555555555555555");
    store.dispatch(ShowLoadingAction(true));
    await FirebaseFirestore.instance
        .collection("Indent_Order")
        .add(action.order.toMap())
        .catchError((onError) {
      store.dispatch(ResetOrder(onError.toString()));
    }).then((value) {
      debugPrint("reset2 middle");
      store.dispatch(ResetOrder(ResponseMessage.success));
      //  store.dispatch(ShowLoadingAction(false));
    });
  } else if (action is FetchStoreDetails) {
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++6666666666666666666666666666");
    store.dispatch(FetchProductsAction());

    var storeSnapShot = await FirebaseFirestore.instance
        .collection("Pos_login")

        .where("StoreCode", isEqualTo: "P099")
        .get();

    if (storeSnapShot.docs.length > 0) {
      storeID = storeSnapShot.docs[0].id;
      data = storeSnapShot.docs[0].data();
      storeCode = data['StoreCode'];
      parlourId = data['parlourId'];
      regionID = data['Ref_Region_Id'];
      zoneID = data['Ref_Zone_Id'];
      storeAddress = data['StoreAddress'];
      contactPerson = data['StoreContactPerson'];

      store.dispatch(StoreDetails(
          storeID,parlourId, storeCode, regionID, zoneID, storeAddress, contactPerson));
      store.dispatch(NavigationClearAllPages(AppRoutes.home));
      store.dispatch(new FetchIndentOrder());

      Map<String, dynamic> inventorySnapShot = (await FirebaseFirestore.instance
          .collection("InventoryChanges")
          .doc("P099")
          .get())
          .data();

      store.dispatch(
          UpdateInventoryQuantity(inventoryQuantity: inventorySnapShot));

      //store.dispatch(action)
    }
  } else if (action is FetchIndentOrder) {
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++77777777777777777777777");
    store.dispatch(ShowLoadingAction(true));
    snapshot = FirebaseFirestore.instance
        .collection("Indent_Order")
        .where("Store_ID", isEqualTo: store.state.storeDetails.storeDocumentID)
        .orderBy('Updated_At', descending: true)
        .snapshots()
        .listen((event) {
      if (event.docs.length > 0) {
        var indentlist = List<IndentOrder>();
        event.docs.forEach((doc) {
          var data = doc.data();
          IndentOrder indentOrder = IndentOrder.fromJson(data);
          indentOrder.docID = doc.id;
          indentlist.add(indentOrder);
        });

        store.dispatch(UpdateOrderHistory(new List<IndentOrder>()));
        store.dispatch(UpdateOrderHistory(indentlist));
      }
    });
  }
  // else if(action is NavigateOrderDetail){
  //
  //
  //    store.dispatch(NavigateAction(AppRoutes.orderdetail));
  // }
  else if (action is UpdatePosSale) {
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++888888888888888888888888888888888888");
    store.dispatch(ShowLoadingAction(true));

    // List<Product>productlist=List();
    // store.state.cart.items
    //   ..forEach((key, value) {
    //     key.selected_quantity = value;
    //     productlist.add(key);
    //   });
    // IndentOrder indentOrder=store.state.indentOrderObj;
    // indentOrder.order_cgst=store.state.cart.total.total_cgst;
    // indentOrder.order_sgst=store.state.cart.total.total_sgst;
    // indentOrder.order_total=store.state.cart.total.total_price;
    // indentOrder.order_subtotal=store.state.cart.total.total_basicprice;
    // indentOrder.order_igst=store.state.cart.total.total_igst;
    // indentOrder.products=productlist;
    // indentOrder.order_gst=store.state.cart.total.total_gst;
    // indentOrder.totalItem=productlist.length;
    // // log(indentOrder.products.toString());
    // // log(indentOrder.toUpdateMap().toString());
    // // log(indentOrder.docID);

    await FirebaseFirestore.instance
        .collection("FRO_Order")
        .add(action.pointOfSaleOrder.toUpdateMap())
        .catchError((e) {
      return false;
    });
    store.dispatch(ResetOrder(""));
    store.dispatch(ShowLoadingAction(false));
    return true;
  } else if (action is FetchOrder) {
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++99999999999999999999999999999999999");
    try {
      String storeID = store.state.storeDetails.storeDocumentID;
      print(storeID);
      print("111111222222222333333");
      print(SharedPrefService.pref.getString('storeId').toString());
      var productsSnapshot = await FirebaseFirestore.instance
          .collection("FRO_Order")
          // .orderBy("Created_At", descending: false)
          .where("Store_Code", isEqualTo: SharedPrefService.pref.getString('storeId').toString())
          .get();
      var pointOfSale = List<PointOfSaleOrder>();
      productsSnapshot.docs.forEach((doc) {
        var data = doc.data();
        PointOfSaleOrder pointOfSaleOrder = PointOfSaleOrder.fromJson(data);
        pointOfSale.add(pointOfSaleOrder);

        //  products.add(Product(data["Product_Id"], data["Product_Name"], data["Product_Unit"], data["Product_MRP"].toDouble(),data["Product_Gst"].toDouble(),data['Product_IGST'].toDouble(),data['Product_CGST'].toDouble(),data['Product_SGST'].toDouble(),data['Product_Gst_Applicable'],data['Product_Basic_Price'].toDouble(),0,doc.id,data['Product_Barcode'],data['Product_Image']));
      });

      store.dispatch(UpdateOrder(pointOfSale));
      store.dispatch(ShowLoadingAction(false));
    } catch (ex) {
      print(ex.toString());
    }
  } else if (action is SearchProduct) {
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++101010010100101");
    List<Product> list;
    if (action.searchText != "") {
      list = store.state.products
          .where((products) => (products.id
          .toLowerCase()
          .contains(action.searchText.toLowerCase()) ||
          products.name
              .toLowerCase()
              .contains(action.searchText.toLowerCase())))
          .toList();
    } else {
      list = null;
    }
    store.dispatch(UpdateSearchProduct(list));
  }

  next(action);
}

