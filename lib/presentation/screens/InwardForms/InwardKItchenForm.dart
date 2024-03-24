import 'dart:async';

import 'package:aavinposfro/API/fetchJson.dart';
import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../routes.dart';

class InwardKitchenForm extends StatefulWidget {
  @override
  _InwardKitchenFormState createState() => _InwardKitchenFormState();
}

class _InwardKitchenFormState extends State<InwardKitchenForm> {
  List formLength=["0"];
  String productID = "";
  String productName = "Not Found";
  DateTime dateTime = DateTime.now();
  _ViewModel _vm;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  var quantity;
  var maxQty=0;
  List kitchenData=[];
  String toParlourID;
  String fromParlourID;
  Map dataMap={};
  Map nameaMap={};
  getKitchenData() async {

  }

  @override
  void initState() {
    var apiData =
    FetchApi().getApi('https://jsonplaceholder.typicode.com/todos/1');
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StoreConnector<AppState, _ViewModel>(
            converter: _ViewModel.fromStore,
            onInit: (store){
              for (Product i in store.state.products)
              {
                for (var j in store.state.inventoryQuantity.keys)
                {
                  if(i.id==j)
                  {
                    kitchenData.add({
                      "id": j,
                      "name": i.name,
                      "qty":store.state.inventoryQuantity[j] ,
                    });
                  }
                }
              }
              // //print(kitchenData);
            },
            builder: (context, vm) {
              this._vm = vm;
              return Scaffold(
                appBar: AppBar(
                  title: Text("Transfer Out"),
                ),
                body: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(20),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           flex: 2,
                          //           child: Text("To Parlour ID",
                          //               textAlign: TextAlign.left,
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.w500))),
                          //       Expanded(
                          //         flex: 5,
                          //         child: TextFormField(
                          //           validator: (value) {
                          //             if (value != null && value != "") {
                          //               return null;
                          //             }
                          //             return "Enter To Parlour ID";
                          //           },
                          //           decoration: InputDecoration(
                          //               enabled: true,
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20)))),
                          //           onChanged: (value) {
                          //             setState(() {
                          //               toParlourID = value;
                          //             });
                          //           },
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
                          //           child: Text("From Parlour ID",
                          //               textAlign: TextAlign.left,
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.w500))),
                          //       Expanded(
                          //         flex: 5,
                          //         child: TextFormField(
                          //           validator: (value) {
                          //             if (value != null && value != "") {
                          //               return null;
                          //             }
                          //             return "Enter From Parlour ID";
                          //           },
                          //           decoration: InputDecoration(
                          //               enabled: true,
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20)))),
                          //           onChanged: (value) {
                          //             setState(() {
                          //               fromParlourID = value;
                          //             });
                          //           },
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
                          //             "From Parlour ID",
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
                          //               _vm.storedetails.storeCode,
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
                          // Padding(
                          //   padding: const EdgeInsets.all(20),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           flex: 2,
                          //           child: Text("Product ID",
                          //               textAlign: TextAlign.left,
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.w500))),
                          //       Expanded(
                          //         flex: 5,
                          //         child: TextFormField(
                          //           validator: (value) {
                          //             if (value != null && value != "") {
                          //               return null;
                          //             }
                          //             return "Enter Product ID";
                          //           },
                          //           decoration: InputDecoration(
                          //               enabled: true,
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20)))),
                          //           onChanged: (value) {
                          //             setState(() {
                          //               setState(() {
                          //                 kitchenData.forEach((element) {
                          //                   if (element["id"] ==
                          //                       value) {
                          //                     setState(() {
                          //                       productName =
                          //                           element["name"];
                          //                       productID = value;
                          //                       maxQty=element["qty"];
                          //                     });
                          //                     //print(element["name"]);
                          //                   } else {
                          //                     //print(element["id"]);
                          //                   }
                          //                 });
                          //               });
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          //
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
                          ...formLength.map((e) {
                            // //print(e.toString());
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Text("Product ID",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500))),
                                      Expanded(
                                        flex: 5,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value != null && value != "") {
                                              return null;
                                            }
                                            return "Enter Product ID";
                                          },
                                          decoration: InputDecoration(
                                              enabled: true,
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20)))),
                                          onChanged: (value) {
                                            // //print("Printing ${e}");
                                            kitchenData.forEach((element) {
                                              if (element["id"] ==
                                                  value) {
                                                setState(() {
                                                  dataMap[element["id"]]=element["qty"];
                                                  nameaMap[element["id"]]=element["name"];
                                                });
                                              } else {

                                              }
                                            });
                                            // //print("dataMap${dataMap} nameMap${nameaMap}");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Product Name",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              ((dataMap.isNotEmpty)&&nameaMap.isNotEmpty&&nameaMap.length-1>=int.parse(e.toString())&&dataMap.length-1>=int.parse(e.toString())?nameaMap[dataMap.keys.toList()[int.parse(e.toString())]]:"Not Found"),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  key: Key(e),
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Text("Product Quantity",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500))),
                                      Expanded(
                                        flex: 5,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value != null && value != ""&& (int.parse(value) <=dataMap.values.toList()[int.parse(e.toString())])&&(dataMap.isNotEmpty)&&nameaMap.isNotEmpty&&nameaMap.length-1>=int.parse(e.toString())&&dataMap.length-1>=int.parse(e.toString())) {
                                              return null;
                                            }

                                            return "Enter valid Quantity, Max :${(dataMap.isNotEmpty)&&nameaMap.isNotEmpty&&nameaMap.length-1>=int.parse(e.toString())&&dataMap.length-1>=int.parse(e.toString())?dataMap.values.toList()[int.parse(e.toString())]:0}";
                                          },
                                          decoration: InputDecoration(
                                              enabled: true,
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20)))),
                                          onChanged: (value) {
                                            setState(() {
                                              quantity = value;
                                              dataMap[dataMap.keys.toList()[int.parse(e.toString())]]=int.parse(value);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 3,
                                  color: Colors.grey[500],
                                )
                              ],
                            );
                          }).toList(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                heroTag: "bt1",
                                child: Icon(Icons.add),
                                onPressed: (){
                                  setState(() {
                                    formLength.add(formLength.length.toString());
                                  });
                                },
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              FloatingActionButton(
                                heroTag: "bt2",
                                child: Icon(Icons.remove),
                                onPressed: (){
                                  if(formLength.length>=1)
                                  {
                                    ////print();
                                    setState(() {
                                      formLength.removeLast();
                                      dataMap.remove(dataMap.keys.toList()[dataMap.length-1]);
                                      nameaMap.remove(nameaMap.keys.toList()[nameaMap.length-1]);
                                    });
                                    // //print(dataMap);
                                    // //print(nameaMap);
                                  }

                                },
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(20),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           flex: 2,
                          //           child: Text("Product Quantity",
                          //               textAlign: TextAlign.left,
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.w500))),
                          //       Expanded(
                          //         flex: 5,
                          //         child: TextFormField(
                          //           validator: (value) {
                          //             if (value != null && value != ""&& int.parse(value) <=maxQty) {
                          //               return null;
                          //             }
                          //
                          //             return "Enter valid Quantity";
                          //           },
                          //           decoration: InputDecoration(
                          //               enabled: true,
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20)))),
                          //           onChanged: (value) {
                          //             setState(() {
                          //               quantity = value;
                          //             });
                          //           },
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
                                      "Date",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: CalendarDatePicker(
                                        onDateChanged: (DateTime value) {
                                          setState(() {
                                            dateTime = value;
                                          });
                                        },
                                        lastDate: DateTime(2100),
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                  // Map temp={};
                                  if (_formKey.currentState.validate()) {
                                    await _ref.collection("KitchenEntries").add({
                                      "Products":dataMap,
                                      "Date": dateTime
                                    });
                                    Map<String,dynamic> temp={};
                                    Map tempInventory = _vm.inventory;
                                    for(String i in dataMap.keys)
                                    {
                                      temp[i]=FieldValue.increment(-1*int.parse(dataMap[i].toString()));
                                      tempInventory[i]= (tempInventory[i]??0) -int.parse(dataMap[i].toString()) ;

                                    }
                                    setState(() {
                                      _vm.updateInventory(tempInventory);
                                    });
                                    await _ref.collection("KitchenInventory").doc(_vm.storedetails.storeCode).update(temp);
                                    Navigator.of(context).pop();
                                  } else {
                                    return;
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
              );
            }));
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
      );

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        store.state.inventoryQuantity,
            (inventory) => store
            .dispatch(UpdateInventoryQuantity(inventoryQuantity: inventory)),
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
            (text) => store.dispatch(SearchProduct(text)));
  }
}
