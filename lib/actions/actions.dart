import 'dart:async';

import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/order.dart';

import '../models/product.dart';

class InitAppAction {}

class FetchProductsAction {

}


class FetchStoreDetails{}

class FetchIndentOrder{}

class FetchOrder{

}

class UpdatePhoneNumber {
  int phoneNumber;
  UpdatePhoneNumber(this.phoneNumber);
  @override
  String toString() {
    return 'phone{phone: $phoneNumber}';
  }
}



class StoreDetails{
  String storeDocumentID;
  String storeCode;
  String regionID;
  String zoneID;
  String storeAddress;
  String contactPerson;
  String parlourId;
  StoreDetails(
      this.parlourId,this.storeDocumentID, this.storeCode, this.regionID, this.zoneID,this.storeAddress,this.contactPerson);
  StoreDetails.fromJson(Map<String, dynamic> json)
      : this.storeDocumentID = json['storeDocumentID'],
        this.storeCode = json['storeCode'],
        this.regionID = json['regionID'],
        this.zoneID = json['zoneID'];
}

class UpdateProductsAction {
  List<Product> products;

  UpdateProductsAction(this.products);

  @override
  String toString() {
    return 'UpdateProductsAction{products: $products}';
  }
}

class UpdateOrderHistory{
  List<IndentOrder>indentOrder;

  UpdateOrderHistory(this.indentOrder);


}

class LoadProductsAction {
  List<Product> products;

  @override
  String toString() {
    return 'LoadProductsAction{products: $products}';
  }
}

class InitStockEditAction {}

class UpdatePosSale{
  final PointOfSaleOrder pointOfSaleOrder;

  UpdatePosSale(this.pointOfSaleOrder);
}

class ShowLoadingAction {
  final bool show;
  ShowLoadingAction(this.show);

  @override
  String toString() {
    return 'ShowLoadingAction{show: $show}';
  }
}
class OnUpdateIndentOrder{

  OnUpdateIndentOrder();
}

class NavigateAction {
  final String route;

  NavigateAction(this.route);

  @override
  String toString() {
    return 'NavigateAction{route: $route}';
  }
}
class NavigationClearAllPages {
  String route;

  NavigationClearAllPages(this.route);
}

class ResetOrder{
  final String message;
 ResetOrder(this.message);
}


class UpdateCartAction {
  Completer<int>completer;
  final String barcode;
  final int quantity;

  UpdateCartAction(this.barcode, this.quantity,this.completer);

  @override
  String toString() {
    return 'UpdateCartAction{product: $barcode, quantity: $quantity}';
  }
}

class EditProductAction {
  final Product product;
  final int quantity;
  final int index;

  EditProductAction(this.product, this.quantity,this.index);

  @override
  String toString() {
    return 'UpdateCartAction{product: $product, quantity: $quantity}';
  }
}
// class NavigateOrderDetail {
//   final IndentOrder indentOrder;
// //  final int quantity;
//
//   NavigateOrderDetail(this.indentOrder);
//
//   @override
//   String toString() {
//     return 'UpdateCartAction{product: $indentOrder}';
//   }
// }

class UpdateOrderAction {
  final Order order;

   UpdateOrderAction(this.order);

  @override
  String toString() {
    return 'UpdateOrderAction{order: $order}';
  }
}

class PlaceOrderAction {
  final IndentOrder order;

  PlaceOrderAction(this.order);

  @override
  String toString() {
    return 'PlaceOrderAction{order: $order}';
  }
}

class MakePaymentAction {}

class UpdateStockAction {
  final Product product;
  final int quantity;

  UpdateStockAction(this.product, this.quantity);

  @override
  String toString() {
    return 'UpdateStockItemAction{item: $product, quantity: $quantity}';
  }
}
class UpdateOrder{
   List<PointOfSaleOrder>posOrder;

   UpdateOrder(this.posOrder);
}

class SubmitStockAction {}

class UpdatePosOrder{
  PointOfSaleOrder pointOfSaleOrder;
  UpdatePosOrder(this.pointOfSaleOrder);
}
class UpdateSearchProduct{
   List<Product>searchProduct;

   UpdateSearchProduct(this.searchProduct);
}

class SearchProduct{
   String searchText;

   SearchProduct(this.searchText);
}
class UpdateDispatchList{
   List dispatchedList;

   UpdateDispatchList({this.dispatchedList});
}
class UpdateNum{
  double num;
  UpdateNum({this.num});
}
class UpdateInventoryQuantity{
   Map inventoryQuantity;

   UpdateInventoryQuantity({this.inventoryQuantity});
}
class UpdatePosSummary{
   List posSummary;

   UpdatePosSummary({this.posSummary});
}
class UpdateSelectedFilterProduct{
   String selectedFilterProduct;

   UpdateSelectedFilterProduct({this.selectedFilterProduct});
}