import 'dart:core';
import 'dart:developer';

import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/presentation/screens/editorder/EditProductList.dart';
import 'package:aavinposfro/presentation/screens/home/indent/products_list.dart';
import 'package:aavinposfro/presentation/screens/home/my_store/update_stock_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './../../../actions/actions.dart';
import './../../../actions/auth_actions.dart';
import '../../../models/app_state.dart';
import '../../../models/indent.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../models/stock.dart';
import '../../../routes.dart';

class EditOrderScreen extends StatefulWidget {
  @override
  EditOrderScreenState createState() => EditOrderScreenState();
}

class EditOrderScreenState extends State<EditOrderScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchTextEditingController =
  new TextEditingController();
  // TabController _tabController;



  final Text _appTitle = Text("Aavin Indent");
  _ViewModel _vm;
  bool _isSearching;
  String _searchInput;
  bool _isFabVisible = false;

  @override
  void initState() {
    super.initState();
    //_tabController = TabController(vsync: this, length: _tabs.length);
    this._searchInput = "";
    this._isSearching = false;

    // _tabController.addListener(_tabListener);

    _searchTextEditingController.addListener(() {
      setState(() {
        this._searchInput = _searchTextEditingController.text;
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
      return this._vm.products!=null?this._vm.products:new List<Product>();
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
      return Stock(items: new Map.fromIterable(filteredListOfStockItems,
          key: (item) => item, value: (item) => this._vm.stock.items[item]));
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

  onPress(){
    _vm.orderhistory();
    _vm.onUpdateorder();
  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        this._vm = vm;
        return Scaffold(
          appBar: AppBar(
            title: _appBarTitle,

            leading: new IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: onPress,
            ),
            backgroundColor:
            _isSearching ? Colors.white : Theme.of(context).primaryColor,
            actions: <Widget>[
//              IconButton(
//                icon: Icon(Icons.search),
//                onPressed: () {
//                  setState(() {
//                    _isSearching = true;
//                  });
//                },
//              ),
            ],
//            bottom: _isSearching
//                ? null
//                : TabBar(
//                    tabs: _tabs,
//                    controller: _tabController,
//                  ),
          ),
          body: vm.isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : EditProductsList(_products, vm.stock, vm.cart,vm.indentorder),

          floatingActionButton: _isFabVisible
              ? FloatingActionButton(
              child: Icon(Icons.edit), onPressed: this._onFabButtonPressed)
              : null,
          bottomNavigationBar: CustomBottomNavigationBar(
              orderTotal:vm.cart.total.total_price, onPressed:(){

          //  vm.updateIndent(vm.indentorder);
            _showDialog("Updated Successfully");

          })
              ,
        );
      },
    );
  }

  _showDialog(String content)async{
    await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Aavin'),
        content: Text(content),
        actions: <Widget>[
          new ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _vm.orderhistory();

            //  vm.back();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );

  }

  switchTab(int tabPosition) {
    // _tabController.animateTo(tabPosition);
  }

  void _tabListener() {
    setState(() {
      //  _isFabVisible = _tabController.index == 0 ? false : true;
    });
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final double orderTotal;
  final Function onPressed;

  const CustomBottomNavigationBar(
      {Key key, @required this.orderTotal, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Grand Total".toUpperCase(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      "₹ $orderTotal",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )

                ],
              ),
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.chevron_right),
                tooltip: 'Place Order',
                onPressed: onPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
  //final IndentOrder indentOrder;
  final Function() checkout;
  final Function() initStockEdit;
  final Function() signOut;
  final IndentOrder indentorder;
  final Function() orderhistory;
  //final Function()
  //final Function(IndentOrder indentOrder) updateIndent;
  final Function() onUpdateorder;

  _ViewModel(this.isLoading, this.user, this.order, this.stock, this.products,
      this.cart, this.checkout, this.initStockEdit, this.signOut,this.phoneNumber,this.orderhistory,
      this.indentorder,this.onUpdateorder);

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
    store.state.indentOrderObj,
            //(IndentOrder indentOrder) =>
      //      store.dispatch(UpdatePosSale(indentOrder)),

          () =>
          store.dispatch(OnUpdateIndentOrder()),

        );
  }
}
