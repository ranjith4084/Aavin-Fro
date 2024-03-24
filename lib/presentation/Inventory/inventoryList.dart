import 'dart:async';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../routes.dart';
class InventoryList extends StatefulWidget {

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  _ViewModel _vm;
  List listViewVar=[];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  getDispatchedList(products,inventoryQuantity) async
  {
    // //print("value");
    // var value = await http.read(Uri.parse(
    //     "https://idms-fed.aavin.tn.gov.in/rest/posApi/fetchParlourReceipt?username=P137&password=Aavin123&tenantId=aavin-fed&parlourId=P137&shipmentId=1565310"));
    List dpList=[];
    for(var i in products)
    {
      for(var j in inventoryQuantity.keys)
      {
        if(i.id==j)
        {
          dpList.add({
            "id":i.id.toString(),
            "qty":inventoryQuantity[j].toString(),
            "name":i.name.toString()
          });
        }
      }
    }
    setState(() {
      listViewVar=dpList;
    });
    //_vm.updateDispatchList(dpList);
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) =>
    //         DispatchedList(dispatchList: dpList,idQtyMap: testMap,)));

  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store){
          for(var i in store.state.products)
          {
            for(var j in store.state.inventoryQuantity.keys)
            {
              if(i.id==j)
              {
                listViewVar.add({
                  "id":i.id.toString(),
                  "qty":store.state.inventoryQuantity[j].toString(),
                  "name":i.name.toString()
                });
              }
            }
          }
          // //print(store.state.products);
        },
        builder: (context, vm) {
          this._vm = vm;
          return Scaffold(

            appBar: AppBar(
              title: Text("Inventory List"),
            ),
            body: ListView.builder(
              itemCount: listViewVar.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(listViewVar[index]["name"].toString()??""),
                    leading: Text(listViewVar[index]["id"].toString()??"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                    trailing: Text(listViewVar[index]["qty"].toString()??"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                  ),
                );
              },),
          );});

  }





}

class _ViewModel {
  final Map inventoryQuantity;
  final Function(List disList) updateDispatchList;
  final bool isLoading;
  final User user;
  final Order order;
  final Stock stock;
  final List<Product> products, searchProducts;
  final Cart cart;
  final int phoneNumber;
  final Function() checkout;
  final Function(String route)navigation;
  final Function() initStockEdit;
  final Function() signOut;
  final Function() orderhistory;
  final Function(PointOfSaleOrder pos ) updatePos;
  final Function() resetOrder;
  final Function(String text) updateSearch;
  final StoreDetails storedetails;
  final Function(String product, int quantity, Completer<int> completer)
  updateCart;
  _ViewModel(
      this.inventoryQuantity,
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
      store.state.inventoryQuantity,
            (disList) =>store.dispatch(UpdateDispatchList(dispatchedList: disList)),
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
