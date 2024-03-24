import 'dart:convert';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:aavinposfro/presentation/screens/home/indent/products_list.dart';
import 'package:aavinposfro/presentation/screens/orderhistory/OrderList.dart';
import 'package:aavinposfro/sharedpreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../routes.dart';
import 'orderdetail_list.dart';

class OrderDetailScreen extends StatefulWidget {
  @override
  OrderDetailScreenScreenState createState() => OrderDetailScreenScreenState();
}

class OrderDetailScreenScreenState extends State<OrderDetailScreen>
    with SingleTickerProviderStateMixin {
  _ViewModel _vm;

  @override
  void initState() {
    super.initState();
  }

  onPress() {
    Navigator.of(context).pop();
    // _vm.orderhistory();
    // _vm.resetIndent();
  }
  static const platform = const MethodChannel('samples.flutter.dev/print');
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
   //   onInit: (store) => store.dispatch(new FetchIndentOrder()),
      builder: (context, vm) {
        this._vm = vm;
        return Scaffold(
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

              // actions: <Widget>[
              //
              //   PopupMenuButton<String>(
              //     onSelected: (value) {
              //       switch (value) {
              //         case  'Edit':
              //           vm.editorder();
              //           break;
              //       }
              //     },
              //     itemBuilder: (BuildContext context) {
              //       return {'Edit'}
              //           .map((String choice) {
              //         return PopupMenuItem<String>(
              //           value: choice,
              //           child: Text(
              //             choice,
              //             style: Theme.of(context).textTheme.headline5,
              //           ),
              //         );
              //       }).toList();
              //     },
              //   ),
              // ],
            ),
            body: vm.isLoading
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
                            "Order Summary",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),

                          SizedBox(
                            height: 16,
                          ),
                          OrderDetailList(items: _vm.pointOfSaleOrder.products),
                          SizedBox(
                            height: 8,
                          ),
                          OrderHistoryTotalContainer(this._vm.pointOfSaleOrder),
                          SizedBox(height: 50,),
                          FractionallySizedBox(
                            widthFactor: 0.4,
                            child: Container(

                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: TextButton(
                                onPressed: ()async {
                                  //print(_vm.pointOfSaleOrder.products);
                                  List<Map<dynamic,dynamic>> map = (_vm.pointOfSaleOrder.products.map((e) {
                                    e.product_basicprice=num.parse(e.product_basicprice.toStringAsFixed(2));
                                    //e.price=num.parse(e.price.toStringAsFixed(2));
                                    //print("printing price${e.toMap()}");
                                    return e.toMap();
                                  }).toList());
//print("here encoded ${json.encode(jsonEncode(map))}");
                                  //print(_vm.pointOfSaleOrder.products);
                                  //print(_vm.pointOfSaleOrder.productList);
                                  bool isSuccess = await platform.invokeMethod('print', <String, dynamic>{
                                    'data': json.encode(jsonEncode(map)),
                                    'orderID': _vm.pointOfSaleOrder.orderID.toString(),
                                    'cgst': _vm.pointOfSaleOrder.cgst.toStringAsFixed(2),
                                    'igst': _vm.pointOfSaleOrder.igst.toStringAsFixed(2),
                                    'sgst': _vm.pointOfSaleOrder.sgst.toStringAsFixed(2),
                                    'subtotal': _vm.pointOfSaleOrder.sub_total.toStringAsFixed(2),
                                    'total': _vm.pointOfSaleOrder.total.toStringAsFixed(2),
                                    'address': SharedPrefService.pref.getString('storeName').toString(),
                                    'paymentmethod': _vm.pointOfSaleOrder.paymentMethod.toString(),
                                    'storecode':SharedPrefService.pref.getString('storeId').toString()

                                  });
                                },
                                child: Text("Print",style: TextStyle(color: Colors.white),),

                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ));
      },
    );
  }

  // List<IndentOrder> get _indentHistory {
  //   //debugPrint(this._vm.products.toString());
  //   return this._vm.orderHistoryAry != null
  //       ? this._vm.orderHistoryAry
  //       : new List<IndentOrder>();
  // }
}

class _ViewModel {
  final StoreDetails storedetails;
  final bool isLoading;
  final User user;

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
      this.user,
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
        store.state.currentUser,
        store.state.order,
        store.state.stock,
        store.state.products,
        store.state.cart,
        () => store.dispatch(NavigateAction(AppRoutes.editorder)),
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
}
