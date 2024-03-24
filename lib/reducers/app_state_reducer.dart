// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:developer';
import 'dart:math' as math;

import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/routes.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/app_state.dart';
import '../models/indent.dart';
import '../models/product.dart';
import '../models/stock.dart';
import 'auth_reducer.dart';

AppState appReducer(AppState state, action) {
  if (action is InitAppAction) {

    final stock = new Stock();
    return state.copyWith(
        isLoading: true,
        stock: Optional.fromNullable(stock),
        updatedStock: Optional.fromNullable(new Map<Product, int>()),
        stockDraft: Optional.fromNullable(stock),

        cart: Optional.fromNullable(new Cart(new Map<Product, int>())));
  }else if (action is UpdateProductsAction) {
    return state.copyWith(
        isLoading: false,
        products: Optional.fromNullable(action.products)
    );
  }
  else if(action is UpdateOrderHistory){
    return state.copyWith(
      isLoading: false,
       // cart: Optional.fromNullable(new Cart(action.indentOrder)),
      indentOrders: Optional.fromNullable(action.indentOrder)
    );
  }
  // else if(action is NavigateOrderDetail){
  //   return state.copyWith(
  //       isLoading: false,
  //       stock: Optional.fromNullable(new Stock()),
  //       updatedStock: Optional.fromNullable(new Map<Product, int>()),
  //       cart: Optional.fromNullable(new Cart(action.indentOrder.items)),
  //       indentorderobj: Optional.fromNullable(action.indentOrder)
  //   );
  // }
  else if(action is ResetOrder){
    var cart=new Cart(new Map<Product, int>());
    var order=new Order(cart);
    return state.copyWith(
        cart: Optional.fromNullable(cart),
        isLoading: false,
        message: action.message,
        indentOrders:  Optional.fromNullable(new List<IndentOrder>()),
        indentorderobj: Optional.fromNullable(null),
        order: Optional.fromNullable(order)
    );
  }
  else if(action is StoreDetails){
    return state.copyWith(
      storeDetails: Optional.fromNullable(new StoreDetails(action.storeDocumentID,action.parlourId,action.storeCode,action.regionID,action.zoneID,action.storeAddress,action.contactPerson))
    );
  }
  else if (action is NavigateAction) {
    return state.copyWith(currentRoute: action.route);
  } else if (action is ShowLoadingAction) {
    return state.copyWith(isLoading: action.show);
  }

  else if (action is UpdateCartAction) {
    Cart currentCart = state.cart;
    List<Product>productlist=state.products.where((element) => element.barcode==action.barcode).toList();
    if(productlist!=null&&productlist.length>0){
      if (action.quantity != null) {
        int selectedquantity=0;
        if(currentCart.items[productlist[0]]!=null){
          selectedquantity=currentCart.items[productlist[0]];
        }
        // //print(action.quantity.toString()+"quan");
        int total=selectedquantity+action.quantity;
        if(total<0){
          total=0;
        }
        // //print(total.toString()+"total");
        currentCart.items[productlist[0]] =total;
      } else {
        currentCart.items.remove(productlist[0]);
      }
      action.completer.complete(1);
    }else{
      action.completer.complete(2);
    }
    return state.copyWith(
        cart: Optional.fromNullable(currentCart),
        order: Optional.fromNullable(new Order(currentCart)));
  } else if (action is UpdateOrderAction) {
    return state.copyWith(order: Optional.fromNullable(action.order));
  }

  else if (action is InitStockEditAction) {
    return state.copyWith(
        stockDraft: Optional.fromNullable(state.stock),
        updatedStock: Optional.fromNullable(new Map<Product, int>()));
  }
  else if(action is OnUpdateIndentOrder){
    return state.copyWith(
      isLoading: false,
      cart: Optional.fromNullable(new Cart(new Map<Product, int>())),
    );
  }
  else if (action is UpdateStockAction) {
    var currUpdatedStock = state.updatedStock;
    var currStockDraft = state.stockDraft;

    if (action.quantity != null) {
      currUpdatedStock[action.product] = action.quantity;
      currStockDraft.items[action.product] = action.quantity;
    } else {
      currUpdatedStock.remove(action.product);
      currStockDraft.items[action.product] = state.stock.items[action.product];
    }
    return state.copyWith(
        stockDraft: Optional.fromNullable(currStockDraft),
        updatedStock: Optional.fromNullable(currUpdatedStock));
  } else if (action is SubmitStockAction) {
    return state.copyWith(
        stock: Optional.fromNullable(
            new Stock(items: state.stockDraft.items, updatedAt: DateTime.now())));
  }else if (action is UpdatePhoneNumber) {
    return state.copyWith(phoneNumber: action.phoneNumber);
  }else if(action is UpdateOrder){
    return state.copyWith(poslist: Optional.fromNullable(action.posOrder));
  }else if(action is UpdatePosOrder){
     return state.copyWith(pointofsaleorder: Optional.fromNullable(action.pointOfSaleOrder));
  }else if(action is UpdateSearchProduct){
     return state.copyWith(searcchproducts: Optional.fromNullable(action.searchProduct));
  }else if(action is UpdateDispatchList){
     return state.copyWith(dispatchedList: action.dispatchedList);
  }else if(action is UpdateInventoryQuantity){
     return state.copyWith(inventoryQuantity: action.inventoryQuantity);
  }else if(action is UpdatePosSummary){
     return state.copyWith(posSummary: action.posSummary);
  }else if(action is UpdateSelectedFilterProduct){
     return state.copyWith(selectedFilterProduct: action.selectedFilterProduct);
  }
  else {
    return combineReducers<AppState>([authReducer])(state, action);
  }
}
