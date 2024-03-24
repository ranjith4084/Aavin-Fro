import 'dart:async';

import 'package:aavinposfro/presentation/screens/PreviousDispatchList/previousDispatchListViewScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../actions/actions.dart';
import '../../../actions/auth_actions.dart';
import '../../../models/PointOfSaleOrderModel.dart';
import '../../../models/app_state.dart';
import '../../../models/indent.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../models/stock.dart';
import '../../../routes.dart';
import '../Summary/pdf.dart';

class previousDispatchList extends StatefulWidget {
  const previousDispatchList({Key key}) : super(key: key);

  @override
  State<previousDispatchList> createState() => _previousDispatchListState();
}

class _previousDispatchListState extends State<previousDispatchList> {
  _ViewModel _vm;
  onPress() {
    Navigator.of(context).pop();
    // _vm.back();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store) {},
        builder: (context, vm) {
          this._vm = vm;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Previous Dispatch List")),
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: onPress,
        ),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Dispatch_Data_entries")
            .where("Parlour_ID", isEqualTo: _vm.storedetails.storeCode)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
         print("++++++++++${ _vm.storedetails.storeCode}");
          return snapshot.data.docs.length!=0 ?
          ListView(
            children: snapshot.data.docs.map(
                  (document) {
                return InkWell(
                  onTap: () {
                    // //print(document['Products']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            previousDispatchListViewScreen(
                              order_ShipmentID: document['Shipment_ID'],
                              order_Product: document['Map_product'],
                              // order_referenceId: document['referenceId'],
                              // order_SubTotal: document['Order_SubTotal'],
                              // order_Cgst: document['Order_Cgst'],
                              // order_Sgst: document['Order_Sgst'],
                              // order_Total: document['Order_Total'],
                              // order_Document_Id: document['Document_Id'],

                            ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                    EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.02, 0.02],
                        colors: [Colors.white, Colors.white],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.6),
                            blurRadius: 5.0),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 5),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Shipment ID: " + document['Shipment_ID'],
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ]),
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(left: 10, top: 5, right: 10),
                            child: Text(
                              "Date: " +
                                  document['Date'] +
                                  " Time: " +
                                  document['Time'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 5),

                          Container(
                            margin: EdgeInsets.only(
                                top: 5, left: 10, right: 10, bottom: 5),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'View Details',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )),
                          )
                        ]),
                  ),
                );
              },
            ).toList(),
          ):Center(child: Text("No items found."));

        },
      ),
    );
  });
  }
}


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

