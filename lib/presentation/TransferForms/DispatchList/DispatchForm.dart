import 'dart:async';
import 'dart:convert';
import 'package:aavinposfro/presentation/TransferForms/DispatchList/DispatchViewScreen.dart';
import 'package:http/http.dart' as http;
import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

import '../../../routes.dart';

class DispatchForm extends StatefulWidget {
  @override
  _DispatchFormState createState() => _DispatchFormState();
}

class _DispatchFormState extends State<DispatchForm> {
  // var testMap = {"T04": 7.0, "M39": 2.0, "B01": 2.0, "J27": 5.0, "Y10": 6.0};
  var finalList = [];
  _ViewModel _vm;
  String parlourID = "";
  String shipmentID = "";
  var quantity;
  DateTime dateTime = DateTime.now();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  List kitchenData;

  // getKitchenData() async {
  //   var data = (await _ref.collection("Inward").get()).docs.map((element) {
  //     return element.data();
  //   }).toList();
  //   setState(() {
  //     kitchenData = data;
  //   });
  //   // //print(kitchenData);
  // }

  getDispatchedList() async {
    // //print("value");
    //////////////////////////////////////////////////////////////////old
    // //print("value");//
    print("+++++++++++++${_vm.storedetails.storeCode}++++++++++++++++++++++++++++${_vm.storedetails.parlourId}++++++++++++++++++++++++++");
    //test
    // var value = await http.read(Uri.parse(
    //     "https://10.236.234.100:22443/rest/posApi/fetchParlourReceipt?username=P167&password=Aavin123&tenantId=aavin-fed&parlourId=$parlourID&shipmentId=${shipmentID}")).catchError((e)=>//print(e.toString()));
      //live
    // var value = await http.read(Uri.parse(
    //     "https://aavin-api.herokuapp.com/")).catchError((e)=>print(e.toString()));
    // //print("000000 The Username  - ${_vm.storedetails.storeCode} and parlour id - ${_vm.storedetails.parlourId} 0000000");
    var value;
     ///old
    if(_vm.storedetails.storeCode=="P171"||_vm.storedetails.storeCode=="P168") {
       value = await http.read(Uri.parse(
          "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchParlourReceipt?username=${_vm.storedetails.storeCode}_PM&password=Aavin123&tenantId=aavin-fed&parlourId=${_vm.storedetails.parlourId}&shipmentId=${shipmentID}")).catchError((e)=>print(e.toString()));

    }

    else{
       value = await http.read(Uri.parse(
          "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchParlourReceipt?username=${_vm.storedetails.storeCode}&password=Aavin123&tenantId=aavin-fed&parlourId=${_vm.storedetails.parlourId}&shipmentId=${shipmentID}")).catchError((e)=>print(e.toString()));

    }
   ///old
    //live
    // var value = await http.read(Uri.parse(
    //     "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchParlourReceipt?username=P167&password=Aavin123&tenantId=aavin-fed&parlourId=P167_PM&shipmentId=1699871")).catchError((e)=>//print(e.toString()));

    // ++https://10.236.234.100:22443/rest/posApi/fetchParlourReceipt?username=P071&password=Aavin123&tenantId=aavin-fed&parlourId=P071_PM&shipmentId=1568410
      //"https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchParlourReceipt?username=P071&password=Aavin123&tenantId=aavin-fed&parlourId=P071_PM&shipmentId=${shipmentID}")).catchError((e)=>//print(e.toString()));
    // //print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

    // //print("printing Value${value}");
    List dpList=[];
    // //print("111111111111111111${jsonDecode(value)["despatchProdQtyDetails"].keys}");
    String zeroindex;
    List keylist=[];
    List valueList=[];
    jsonDecode(value)["despatchProdQtyDetails"].forEach((key, value){
      // //print('key is $key');
      keylist.add(key);
      valueList.add(value);
       // zeroindex=key(0);
      // //print('value is $value ');

    });

    print("56546546+++++++++++${keylist}");




    // //print("22222222222222222222222${jsonDecode(value)["despatchProdQtyDetails"][0].keys.floor()}");
    for(var i in _vm.products)
    {
      for(var j in jsonDecode(value)["despatchProdQtyDetails"].keys)
      {
        if(i.id==j)
        {
          dpList.add({
            "id":i.id.toString(),
            "qty":jsonDecode(value)["despatchProdQtyDetails"][keylist[0]].floor(),
            "name":i.name.toString()
          });
        }
      }
    }
    _vm.updateDispatchList(dpList);
    // //print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print( _vm.storedetails.storeCode);
    print(valueList);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>
            DispatchedList(dispatchList: dpList,idQtyMap: jsonDecode(value)["despatchProdQtyDetails"],shipmentID: shipmentID,parlourID:_vm.storedetails.storeCode,valueList:valueList,keylist:keylist)));
    //////////////////////////////////////////////////////////////////new

  }

  @override
  void initState() {
    super.initState();
    //getDispatchedList();
    //getKitchenData();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store) {},
        builder: (context, vm) {
          this._vm = vm;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Dispatched Data"),
              ),
              body: SingleChildScrollView(
                child: Form(
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
                        //           child: Text(
                        //             "Parlour ID",
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
                        //               return "Enter Parlour ID";
                        //             },
                        //             decoration: InputDecoration(
                        //                 enabled: true,
                        //                 border: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20)))),
                        //             onChanged: (value) {
                        //               setState(() {
                        //                 parlourID = value;
                        //               });
                        //             },
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
                                    "Shipment ID",
                                    textAlign: TextAlign.left,
                                  )),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value != null && value != "") {
                                        return null;
                                      }
                                      return "Enter Shipment ID";
                                    },
                                    decoration: InputDecoration(
                                        enabled: true,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    onChanged: (value) {
                                      setState(() {
                                        shipmentID = value;
                                      });
                                    },
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
                                if (_formKey.currentState.validate()) {
                                getDispatchedList();

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
  final Function(List disList) updateDispatchList;
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
      this.updateDispatchList,
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
      this.updateSearch);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        (disList) =>
            store.dispatch(UpdateDispatchList(dispatchedList: disList)),
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
