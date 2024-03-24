import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiver/core.dart';

import 'indent.dart';
import 'order.dart';

class AppState {
  double num=0.0;
  final bool isLoading;
  final User currentUser;
  final String currentRoute;
  final String message;
  final List<Product> products,searchProducts;
  final Stock stock;
  final PointOfSaleOrder pointOfSaleOrder;
  final Stock stockDraft;
  final Map<Product, int> updatedStock;
  final Order order;
  final int phoneNumber;
  final String email;
  final Cart cart;
  final StoreDetails storeDetails;
  final List<IndentOrder>indentOrder;
  final IndentOrder indentOrderObj;
  final List<PointOfSaleOrder>posList;
  final List dispatchedList;
  final Map inventoryQuantity;
  final List posSummary;
  final String selectedFilterProduct;
  AppState(
      {this.isLoading = false,
        this.phoneNumber,
        this.num,
        this.currentUser,
        this.email,
        this.currentRoute = '/login',
        this.products,
        this.message,
        this.stock,
        this.stockDraft,
        this.updatedStock,
        this.order,
        this.cart,
        this.storeDetails,
        this.indentOrder,
        this.indentOrderObj,
       this.posList,
      this.pointOfSaleOrder,
      this.searchProducts,
      this.dispatchedList,
      this.inventoryQuantity,
      this.posSummary,
      this.selectedFilterProduct});

  AppState copyWith({
    bool isLoading,
double num,
    int phoneNumber,
    String email,
    Optional<User> currentUser,
    String currentRoute,
    Optional<List<Product>> products,
    String message,
    Optional<Stock> stock,
    Optional<Stock> stockDraft,
    Optional<Map<Product, int>> updatedStock,
    Optional order,
    Optional<Cart> cart,
    Optional<PointOfSaleOrder> pointofsaleorder,
    Optional storeDetails,
    Optional<List<IndentOrder>>indentOrders,
    Optional<List<PointOfSaleOrder>>poslist,
    Optional indentorderobj,
    Optional<List<Product>> searcchproducts,
    List dispatchedList,
    Map inventoryQuantity,
    List posSummary,
    String selectedFilterProduct
  }) {
    return AppState(
      num: num ?? this.num,
        isLoading: isLoading ?? this.isLoading,
      email:email==null?this.email:email,
        phoneNumber:phoneNumber==null?this.phoneNumber:phoneNumber,
        currentUser: currentUser == null ? this.currentUser : currentUser.orNull,
        currentRoute: currentRoute ?? this.currentRoute,
        message: message??this.message,
        pointOfSaleOrder: pointofsaleorder ==null ?this.pointOfSaleOrder:pointofsaleorder.orNull,
        posList: poslist == null ?this.posList:poslist.orNull,
        products: products == null ? this.products : products.orNull,
        stock: stock == null ? this.stock : stock.orNull,
        stockDraft: stockDraft == null ? this.stockDraft : stockDraft.orNull,
        updatedStock: updatedStock == null ? this.updatedStock : updatedStock.orNull,
        order: order == null ? this.order : order.orNull,
        indentOrderObj: indentorderobj==null?this.indentOrderObj:indentorderobj.orNull,
        storeDetails: storeDetails == null ? this.storeDetails : storeDetails.orNull,
        cart: cart == null ? this.cart : cart.orNull,
        searchProducts: searcchproducts == null ? this.searchProducts:searcchproducts.orNull,
        indentOrder: indentOrders == null ? this.indentOrder : indentOrders.orNull,
        dispatchedList: dispatchedList ?? this.dispatchedList,
        inventoryQuantity: inventoryQuantity ?? this.inventoryQuantity,
        posSummary: posSummary ?? this.posSummary,
        selectedFilterProduct: selectedFilterProduct ?? this.selectedFilterProduct,
        );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          email == other.email &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          posList  == other.posList &&
          message == other.message &&
          phoneNumber==other.phoneNumber&&
          indentOrderObj==other.indentOrderObj&&
          currentUser == other.currentUser &&
          storeDetails == other.storeDetails&&
          currentRoute == other.currentRoute &&
          products == other.products &&
          pointOfSaleOrder == other.pointOfSaleOrder &&
          searchProducts == other.searchProducts &&
          stock == other.stock &&
          stockDraft == other.stockDraft &&
          updatedStock == other.updatedStock &&
          order == other.order &&
          indentOrder == other.indentOrder&&
          cart == other.cart&&
          dispatchedList==other.dispatchedList&&
          inventoryQuantity==other.inventoryQuantity&&
          posSummary==other.posSummary&&
          selectedFilterProduct==other.selectedFilterProduct;

  @override
  String toString() {
    return 'AppState{isLoading: $indentOrderObj,message:$message,storedetails:$storeDetails, phone:$phoneNumber, currentUser: $currentUser, currentRoute: $currentRoute, products: $products, stock: $stock, stockDraft: $stockDraft, updatedStock: $updatedStock, order: $order,cart: $cart}';
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      indentOrderObj.hashCode^
      currentUser.hashCode ^
      message.hashCode ^
      email.hashCode^
      phoneNumber.hashCode^
      currentRoute.hashCode ^
      products.hashCode ^
      posList.hashCode^
      storeDetails.hashCode^
      stock.hashCode ^
      searchProducts.hashCode^
      pointOfSaleOrder.hashCode^
      stockDraft.hashCode ^
      updatedStock.hashCode ^
      indentOrder.hashCode^
      order.hashCode ^
      cart.hashCode^
      dispatchedList.hashCode^
      inventoryQuantity.hashCode^
      posSummary.hashCode^
      num.hashCode^
      selectedFilterProduct.hashCode;
}
