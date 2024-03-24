// import 'dart:async';
//
// import 'package:aavinposfro/actions/actions.dart';
// import 'package:aavinposfro/models/app_state.dart';
// import 'package:aavinposfro/models/indent.dart';
// import 'package:aavinposfro/models/product.dart';
// import 'package:aavinposfro/presentation/widgets/tag.dart';
// import 'package:aavinposfro/utils/StringUtils.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
//
// class ProductCard extends StatefulWidget {
//   final Product product;
//   final int cartQuantity;
//   final int stockQuantity;
//
//   const ProductCard(this.product,
//       {int cartQuantity, int stockQuantity, Key key})
//       : this.cartQuantity = cartQuantity ?? 0,
//         this.stockQuantity = stockQuantity ?? 0,
//         super(key: key);
//
//   @override
//   _ProductCardState createState() => _ProductCardState();
// }
//
//
//
// class _ProductCardState extends State<ProductCard> {
//   _ViewModel vm;
//   TextEditingController _quantityEditingController;
//
//   @override
//   void initState() {
//     _quantityEditingController = TextEditingController(
//         text: widget.cartQuantity == 0 ? null : widget.cartQuantity.toString());
//     _quantityEditingController.addListener(() {
//       int quantity = _quantityEditingController.text.isEmpty
//           ? null
//           : int.tryParse(_quantityEditingController.text);
//
//     });
//
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, _ViewModel>(
//         converter: _ViewModel.fromStore,
//         builder: (context, vm) {
//           this.vm = vm;
//           return vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null?StreamBuilder(
//               stream: null,
//               builder: (context, snapshot) {
//                 return Card(
//                   child: Container(
//                     color: Colors.white,
//
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//
//                             vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null?Expanded(
//                               flex: 2,
//                               child: Container(
//                                 margin: EdgeInsets.only(left: 5),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       child: Text(
//                                         widget.product.name,
//                                         style: TextStyle(fontSize: 18),
//                                       ),
//                                     ),
//                                     widget.product.price!=null?Container(
//                                       child: Text("₹ ${widget.product.price.toStringAsFixed(2).toString()}",
//                                           style: TextStyle(
//                                               fontSize: 20, color: Color(0xFF888888))),
//                                     ):Text("Not For Sale")
//
//                                   ],
//                                 ),
//                               ),
//                             ):SizedBox.shrink(),
//                             vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null&&widget.product.price!=null?Expanded(
//                               flex: 0,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Color(0xFFEFEFEF),
//                                     ),
//                                     child: Row(
//                                       children: <Widget>[
//                                         InkWell(
//                                           onTap: () {
//                                             updateProduct(widget.product.barcode, -1);
//
//                                           },
//                                           child: Container(
//                                             padding: EdgeInsets.only(
//                                                 left: 20,
//                                                 right: 20,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             child: Icon(
//                                               Icons.remove,
//                                               size: 18.0,
//                                             ),
//                                           ),
//                                         ),
//
//                                         Text(widget.cartQuantity.toString()),
//
//                                         InkWell(
//                                           onTap: () {
//
//                                             if(widget.cartQuantity<vm.inventory[widget.product.barcode])
//                                             {
//
//                                               updateProduct(widget.product.barcode, 1);
//                                               //print( widget.cartQuantity);
//                                             }
//
//                                           },
//                                           child: Container(
//                                             padding: EdgeInsets.only(
//                                                 left: 20,
//                                                 right: 20,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             child: Icon(
//                                               Icons.add,
//                                               size: 18.0,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ):SizedBox.shrink(),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 );
//               }
//           ):Container();
//         });
//   }
//
//   void updateProduct(String bacode,int qty){
//     Completer<int>completer=Completer();
//     vm.updateCart(bacode, qty,completer);
//   }
//
//   @override
//   void dispose() {
//     _quantityEditingController.dispose();
//     super.dispose();
//   }
// }
//
// class QuantityField extends StatelessWidget {
// //  final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController controller;
//
//   const QuantityField({Key key, this.controller}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       TextFormField(
//         controller: controller,
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.phone,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly,
//           LengthLimitingTextInputFormatter(3)
//         ],
//         validator: (input) {
//           var quantity = int.tryParse(input) ?? 0;
//           if (input.length > 0 && quantity < 1) {
//             return "Invalid";
//           } else
//             return null;
//         },
//         decoration: InputDecoration(
//             hintText: "0",
//             contentPadding: EdgeInsets.all(8),
//             border: OutlineInputBorder(gapPadding: 1)),
//       );
// //    );
//   }
// }
//
// class _ViewModel {
//   final inventory;
//   final Cart cart;
//   final Function(String product, int quantity,Completer<int>completer) updateCart;
//
//   _ViewModel(this.inventory,this.cart,this.updateCart);
//
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//         store.state.inventoryQuantity,
//         store.state.cart,
//             (product,quantity,completer)=>store.dispatch(UpdateCartAction(product, quantity, completer)));
//   }
// }
//
import 'dart:async';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/presentation/widgets/tag.dart';
import 'package:aavinposfro/utils/StringUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final int cartQuantity;
  final int stockQuantity;

  const ProductCard(this.product,
      {int cartQuantity, int stockQuantity, Key key})
      : this.cartQuantity = cartQuantity ?? 0,
        this.stockQuantity = stockQuantity ?? 0,
        super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  _ViewModel vm;
  TextEditingController _quantityEditingController;

  @override
  void initState() {
    _quantityEditingController = TextEditingController(
        text: widget.cartQuantity == 0 ? null : widget.cartQuantity.toString());
    _quantityEditingController.addListener(() {
      int quantity = _quantityEditingController.text.isEmpty
          ? null
          : int.tryParse(_quantityEditingController.text);
      //  vm.updateCart("B01", quantity);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          this.vm = vm;
          return Card(
            child: Container(
              color: Colors.white,

//            color: Colors.grey[200],

              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              // decoration: BoxDecoration(
              //     color: Color(0xFFF6F6F6),
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(20),
              //       topRight: Radius.circular(20),
              //     )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // CachedNetworkImage(
                      //   imageUrl: StringUtils.baseurl+widget.product.image,
                      //   height: 70,
                      //   width: 70,
                      //   fit: BoxFit.contain,
                      // ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  widget.product.name,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Container(
                                child: Text(widget.product.size,
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0xFF888888))),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "₹" + (widget.product.price.toStringAsFixed(2)),
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFF3A69DB)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null?Expanded(
                        flex: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFEFEFEF),
                              ),
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      updateProduct(widget.product.barcode, -1);
                                      //    vm.updateCart(widget.product.barcode, -1);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      child: Icon(
                                        Icons.remove,
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  Text(widget.cartQuantity.toString()),
                                  // SizedBox(
                                  //   width: 10,
                                  // xewx),
                                  InkWell(
                                    onTap: () {

                                      if(widget.cartQuantity<vm.inventory[widget.product.barcode])
                                      {
                                        updateProduct(widget.product.barcode, 1);
                                      }
                                      // print(vm.cart.items.keys.toList());
                                      // if(vm.cart.items.keys.toList().isEmpty&&vm.inventory[widget.product.barcode]>0)
                                      //   {
                                      //     updateProduct(widget.product.barcode, 1);
                                      //     return ;
                                      //   }
                                      // for(var i in vm.cart.items.keys.toList())
                                      //   {
                                      //     print(i);
                                      //     if(vm.inventory[widget.product.barcode]>0){
                                      //       updateProduct(widget.product.barcode, 1);
                                      //     }
                                      //   }
                                      //
                                      //vm.updateCart();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      child: Icon(
                                        Icons.add,
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ):Text("Not available"),
                    ],
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 10),
                  //   child: Divider(
                  //     height: 1,
                  //     color: Colors.grey,
                  //   ),
                  // )
                ],
              ),
            ),
          );
        });
  }

  void updateProduct(String bacode,int qty){
    Completer<int>completer=Completer();
    vm.updateCart(bacode, qty,completer);
  }

  @override
  void dispose() {
    _quantityEditingController.dispose();
    super.dispose();
  }
}

class QuantityField extends StatelessWidget {
//  final _formKey = GlobalKey<FormState>();

  final TextEditingController controller;

  const QuantityField({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
//      Form(
//      key: _formKey,
//      autovalidate: true,
//      child:
      TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.phone,

        validator: (input) {
          var quantity = int.tryParse(input) ?? 0;
          if (input.length > 0 && quantity < 1) {
            return "Invalid";
          } else
            return null;
        },
        decoration: InputDecoration(
            hintText: "0",
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(gapPadding: 1)),
      );
//    );
  }
}

class _ViewModel {
  final inventory;
  final Cart cart;
  final Function(String product, int quantity,Completer<int>completer) updateCart;

  _ViewModel(this.inventory,this.cart,this.updateCart);


  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        store.state.inventoryQuantity,
        store.state.cart,
            (product,quantity,completer)=>store.dispatch(UpdateCartAction(product, quantity, completer)));
  }
}

//  Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           widget.product.name,
//                           style: Theme.of(context).textTheme.headline5,
//                         ),
//                         SizedBox(
//                           height: 4,
//                         ),
//                         Wrap(
//                           spacing: 8,
//                           children: <Widget>[
//                             Tag(
//                               label: Text(
//                                 widget.product.id,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText1
//                                     .copyWith(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                               ),
//                             ),
//                             Tag(
//                               label: Text("₹",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyText1
//                                       .copyWith(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white)),
//                               child: Text(widget.product.price.toString(),
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyText1
//                                       .copyWith(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                       )),
//                               color: Colors.blue[400],
//                             ),
//                             if (widget.stockQuantity > 0)
//                               Tag(
//                                 label: Icon(
//                                   Icons.store_mall_directory,
//                                   color: Colors.white,
//                                   size: 14,
//                                 ),
//                                 child: Text(widget.stockQuantity.toString(),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyText1
//                                         .copyWith(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                         )),
//                                 color: Colors.green[400],
//                               )
//                           ],
//                         ),

//                       ],
//                     ),
//                     Column(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(right: 10),
//                           height: 50,
//                           decoration: BoxDecoration(
//                               color: Colors.grey,
//                               borderRadius:
//                               BorderRadius.all(
//                                   Radius.circular(10))),
//                           child: Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               IconButton(
//                                 padding: EdgeInsets.all(0),
//                                 onPressed: () {
//                                   vm.updateCart(widget.product.barcode,-1);

//                                 },
//                                 icon: Icon(Icons.remove),
//                               ),
//                               Text(widget.cartQuantity.toString()
//                                   .toString(),
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black,

//                                   )),
//                               IconButton(
//                                 padding: EdgeInsets.all(0),
//                                 onPressed: () {
//                                   vm.updateCart(widget.product.barcode,1);
//                                 },
//                                 icon: Icon(Icons.add),
//                               )
//                             ],
//                           ),
//                         ),
// //                        Container(
// //                          width: 64,
// //                          child: Text(
// //                            widget.cartQuantity.toString()
// //                          )
// //                        ),
//                         if (widget.cartQuantity > 0)
//                           Column(
//                             children: <Widget>[
//                               SizedBox(
//                                 height: 4,
//                               ),
//                               Text("₹ ${widget.product.price * widget.cartQuantity}")
//                             ],

//                           ),

//                       ],

//                     )
//                   ],
//                 ),
