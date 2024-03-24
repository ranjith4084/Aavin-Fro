import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:convert';

import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/presentation/screens/home/Home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:uuid/uuid.dart';

import '../../../actions/actions.dart';
import './../../../actions/auth_actions.dart';
import '../../../models/app_state.dart';
import '../../../models/indent.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../models/stock.dart';
import '../../../routes.dart';
import 'indent/products_list.dart';
import 'my_store/stock_container.dart';
import 'my_store/update_stock_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchTextEditingController = new TextEditingController();
  TabController _tabController;

  final List<Tab> _tabs = <Tab>[
    Tab(text: "INDENT"),
    Tab(text: "STOCK"),
  ];

  final Text _appTitle = Text("Aavin Indent");
  _ViewModel _vm;
  bool _isSearching;
  String _searchInput;
  bool _isFabVisible = false;
  static const platform = const MethodChannel('samples.flutter.dev/print');
  AudioPlayer audioPlayer;
  AudioCache cache = new AudioCache();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
    this._searchInput = "";
    this._isSearching = false;

    _tabController.addListener(_tabListener);

    _searchTextEditingController.addListener(() {
      setState(() {
        this._searchInput = _searchTextEditingController.text;
        // //print(_searchInput);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
    this._searchTextEditingController.dispose();
  }

  void _onFabButtonPressed() {
    Navigator.of(context).push(new MaterialPageRoute<UpdateStockDialog>(
        builder: (BuildContext context) {
          _vm.initStockEdit();
          return new UpdateStockDialog();
        },
        fullscreenDialog: true));
  }

  void _onAppbarIconButtonPressed() {
    setState(() {
      this._isSearching = false;
    });
  }

  List<Product> get _products {
    if (this._isSearching && this._searchInput.length > 0) {
      return this
          ._vm
          .products
          .where((product) =>
              product.name.toLowerCase().contains(this._searchInput))
          .toList();
    } else {
      return this._vm.products != null
          ? this._vm.products
          : new List<Product>();
    }
  }

  Stock get _stock {
    if (this._isSearching && this._searchInput.length > 0) {
      var filteredListOfStockItems = this
          ._vm
          .stock
          .items
          .keys
          .where((product) =>
              product.name.toLowerCase().contains(this._searchInput))
          .toList();
      return Stock(
          items: new Map.fromIterable(filteredListOfStockItems,
              key: (item) => item,
              value: (item) => this._vm.stock.items[item]));
    } else {
      return this._vm.stock;
    }
  }

  get _appBarTitle {
    return this._isSearching
        ? SearchTextField(
            searchTextEditingController: _searchTextEditingController,
          )
        : _appTitle;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        this._vm = vm;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: _appBarTitle,
            leading: this._isSearching
                ? new IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: _onAppbarIconButtonPressed,
                  )
                : null,
            backgroundColor:
                _isSearching ? Colors.white : Theme.of(context).primaryColor,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  startBarcodeScanStream();
//                  setState(() {
//                    _isSearching = true;
//                  });
                },
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'Order History':
                      vm.orderhistory();
                      break;
                    case 'Logout':
                      vm.signOut();
                      break;
                    case 'Settings':
                      break;
                    default:
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Order History', 'Settings', 'Logout'}
                      .map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    );
                  }).toList();
                },
              ),
            ],
            // bottom: _isSearching
            //     ? null
            //     : TabBar(
            //         tabs: _tabs,
            //        controller: _tabController,
            //      ),
          ),
          body: HomePage(
            products: _vm.products,
            stock: _vm.stock,
            cart: _vm.cart,
          ) // vm.isLoading
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :
          //  TabBarView(controller: _tabController, children: <Widget>[
          //    ProductsList(_products, vm.stock, vm.cart),

          //         StockContainer(_stock)
          //       ]),
          ,
          floatingActionButton: _isFabVisible
              ? FloatingActionButton(
                  child: Icon(Icons.edit), onPressed: this._onFabButtonPressed)
              : null,
          // bottomNavigationBar: vm.cart != null &&
          //         vm.cart.total != null &&
          //         vm.cart.items.length > 0
          //     ? CustomBottomNavigationBar(
          //         orderTotal: vm.cart.total.total_price,
          //         onPressed: () => {onClick()})
          //     : SizedBox.shrink(),
        );
      },
    );
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Done", true, ScanMode.BARCODE)
        .then((barcode) {
      if (barcode != null && barcode.length > 1) {
        play(barcode);
      }
    });
  }

  String barcode="";

  void play(String barcode) async {
    if (barcode == "1") {
    } else if (barcode == "-1") {
    } else {

      Completer<int>completer=Completer();
      _vm.updateCart(barcode, 1,completer);
      completer.future.then((value) async{
          if(value==1){
            await cache.play('beep.mp3');
          }
         this.barcode=barcode;
      });
    }
  }

  onClick(int paymentMethod) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    List<Product> productlist = List();
    _vm.order.cart.items
      ..forEach((key, value) {
        key.selected_quantity = value;
        productlist.add(key);
      });
      var  map = jsonEncode(productlist.map((e) => e.toMap()).toList());


      // PointOfSaleOrder pointOfSaleOrder=PointOfSaleOrder(timestamp.toString(),  _vm.cart.total.total_cgst,  _vm.cart.total.total_sgst,  _vm.cart.total.total_igst,  _vm.cart.total.total_price, map, paymentMethod,  _vm.cart.total.total_basicprice, _vm.storedetails.storeDocumentID, _vm.storedetails.storeCode,
      //     _vm.storedetails.regionID, _vm.storedetails.zoneID,_vm.cart.total.total_gst);

      bool isSuccess = await platform.invokeMethod('print', <String, dynamic>{
      'data': json.encode(map),
      'orderID': timestamp.toString(),
      'total': _vm.cart.total.total_price,
      'address': _vm.storedetails.storeAddress
    });
    if (isSuccess) {
      _vm.resetOrder();
    } else {
      // debugPrint("not printed");
    }
  }

  switchTab(int tabPosition) {
    _tabController.animateTo(tabPosition);
  }

  void _tabListener() {
    setState(() {
      _isFabVisible = _tabController.index == 0 ? false : true;
    });
  }
}

// class CustomBottomNavigationBar extends StatelessWidget {
//   final double orderTotal;
//   final Function onPressed;

//   const CustomBottomNavigationBar(
//       {Key key, @required this.orderTotal, @required this.onPressed})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 72,
//       child: BottomAppBar(
//         color: Theme.of(context).primaryColor,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Grand Total".toUpperCase(),
//                     style: TextStyle(fontSize: 12, color: Colors.white),
//                   ),
//                   Expanded(
//                     child: Text(
//                       "₹ $orderTotal",
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               ),
//               IconButton(
//                 color: Colors.white,
//                 icon: Icon(Icons.chevron_right),
//                 tooltip: 'Place Order',
//                 onPressed: onPressed,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class SearchTextField extends StatelessWidget {
  final TextEditingController searchTextEditingController;

  const SearchTextField({Key key, this.searchTextEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextEditingController,
      autofocus: true,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          hintStyle:
              TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
      style: TextStyle(color: Colors.grey[500]),
    );
  }
}

class _ViewModel {
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
  final Function(String product, int quantity,Completer<int>completer) updateCart;

  _ViewModel(
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
      this.updateCart);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
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
        (product, quantity,completer) =>
            store.dispatch(UpdateCartAction(product, quantity,completer)));
  }
}
