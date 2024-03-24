import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:aavinposfro/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'ProductDetailCard.dart';

class ChosenProducts extends StatefulWidget {
  @override
  _ChosenProductsState createState() => _ChosenProductsState();
}

class _ChosenProductsState extends State<ChosenProducts> {
  createRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'text1',
          style: TextStyle(fontSize: 15),
        ),
        Text('text2', style: TextStyle(fontSize: 15))
      ],
    );
  }

  ViewModel _vm;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: ViewModel.fromStore,
        builder: (context, vm) {
          this._vm = vm;
          // //print(vm.cart.items);
          return Scaffold(
            appBar: AppBar(
              title: Text('Heading'),
              centerTitle: true,
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView.builder(
                            itemCount: vm.cart.items.keys.length,
                            itemBuilder: (BuildContext context, index) {
                              return ProductDetailCard();
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price Details',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        createRow(),
                        SizedBox(
                          height: 10,
                        ),
                        createRow(),
                        SizedBox(
                          height: 10,
                        ),
                        createRow(),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text("₹" + _vm.cart.total.total_price.toStringAsFixed(2),
                                style: TextStyle(fontSize: 20))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Total Amount',
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  "₹" + _vm.cart.total.total_price.toStringAsFixed(2),
                                  style: TextStyle(fontSize: 20))),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF1D8DCF)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)))),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container();
                                      });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    'Proceed',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class ViewModel {
  final bool isLoading;
  final User user;

  final Order order;
  final Stock stock;
  final List<Product> products;
  final Cart cart;

  final int phoneNumber;
  final Function() checkout;
  final Function() initStockEdit;
  final Function() signOut;
  final Function() orderhistory;
  final Function() resetOrder;

  final StoreDetails storedetails;
  //final Function(String product, int quantity) updateCart;

  ViewModel(
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
    //  this.updateCart
      );

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
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
       );
  }
}
