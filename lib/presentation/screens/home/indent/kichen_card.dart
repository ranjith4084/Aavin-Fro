// import 'dart:async';
//
// import 'package:aavinposfro/actions/actions.dart';
// import 'package:aavinposfro/models/app_state.dart';
// import 'package:aavinposfro/models/indent.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:redux/redux.dart';
// //
// class KichenCard extends StatefulWidget {
//   List invertoryList;
//
//   KichenCard(this.invertoryList);
//
//   @override
//   _KichenCardState createState() => _KichenCardState();
// }
//
// class _KichenCardState extends State<KichenCard> {
//   _ViewModel vm;
//   TextEditingController _quantityEditingController;
//   List Kichprod;
//
//   @override
//   void initState() {
//     // initSetup();
//     super.initState();
//   }
//
//   // Map invertory = {};
//   // initSetup() async {
//   //
//   //   DocumentSnapshot snapshot = (await FirebaseFirestore.instance
//   //       .collection("KitchenProduct")
//   //       .doc("N41")
//   //       .get());
//   //   invertory = snapshot.data();
//   //   //print("777$invertory");
//   //   return invertory;
//   // }
//   int _itemCount = 0;
//
//   @override
// //   Widget build(BuildContext context) {
// //     return StoreConnector<AppState, _ViewModel>(
// //         converter: _ViewModel.fromStore,
// //         builder: (context, vm) {
// //           this.vm = vm;
// //           return vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null?StreamBuilder(
// //               stream: null,
// //               builder: (context, snapshot) {
// //                 return Card(
// //                   child: Container(
// //                     color: Colors.white,
// //
// // //            color: Colors.grey[200],
// //
// //                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                     // decoration: BoxDecoration(
// //                     //     color: Color(0xFFF6F6F6),
// //                     //     borderRadius: BorderRadius.only(
// //                     //       topLeft: Radius.circular(20),
// //                     //       topRight: Radius.circular(20),
// //                     //     )),
// //                     child: Column(
// //                       children: [
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             // CachedNetworkImage(
// //                             //   imageUrl: StringUtils.baseurl+widget.product.image,
// //                             //   height: 70,
// //                             //   width: 70,
// //                             //   fit: BoxFit.contain,
// //                             // ),
// //                             vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null?Expanded(
// //                               flex: 2,
// //                               child: Container(
// //                                 margin: EdgeInsets.only(left: 5),
// //                                 child: Column(
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Container(
// //                                       child: Text(
// //                                         widget.product.name,
// //                                         style: TextStyle(fontSize: 18),
// //                                       ),
// //                                     ),
// //                                     Container(
// //                                       child: Text(widget.product.size,
// //                                           style: TextStyle(
// //                                               fontSize: 20, color: Color(0xFF888888))),
// //                                     ),
// //                                     vm.inventory[widget.product.price.toStringAsFixed(2)]!=0.0&&vm.inventory[widget.product.price.toStringAsFixed(2)]!=null&&vm.inventory[widget.product.price.toStringAsFixed(2)]!=0?null:Container(
// //                                       margin: EdgeInsets.only(top: 10),
// //                                       child: Text(
// //                                         "₹" + (widget.product.price.toStringAsFixed(2)),
// //                                         style: TextStyle(
// //                                             fontSize: 20, color: Color(0xFF3A69DB)),
// //                                       ),
// //                                     ),
// //                                     // Container(
// //                                     //   margin: EdgeInsets.only(top: 10),
// //                                     //   child: Text(
// //                                     //     "₹" + (vm.inventory[widget.product.price.toStringAsFixed(2)]!=0.0&&vm.inventory[widget.product.price.toStringAsFixed(2)]!=null?widget.product.price.toStringAsFixed(2):""),
// //                                     //     style: TextStyle(
// //                                     //         fontSize: 20, color: Color(0xFF3A69DB)),
// //                                     //   ),
// //                                     // ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ):SizedBox.shrink(),
// //                             vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null?Expanded(
// //                               flex: 0,
// //                               child: Column(
// //                                 mainAxisSize: MainAxisSize.min,
// //                                 mainAxisAlignment: MainAxisAlignment.end,
// //                                 children: [
// //                                   SizedBox(
// //                                     height: 20,
// //                                   ),
// //                                   Container(
// //                                     decoration: BoxDecoration(
// //                                       borderRadius: BorderRadius.circular(10),
// //                                       color: Color(0xFFEFEFEF),
// //                                     ),
// //                                     child: Row(
// //                                       children: <Widget>[
// //                                         InkWell(
// //                                           onTap: () {
// //                                             updateProduct(widget.product.barcode, -1);
// //                                             //    vm.updateCart(widget.product.barcode, -1);
// //                                           },
// //                                           child: Container(
// //                                             padding: EdgeInsets.only(
// //                                                 left: 20,
// //                                                 right: 20,
// //                                                 top: 10,
// //                                                 bottom: 10),
// //                                             child: Icon(
// //                                               Icons.remove,
// //                                               size: 18.0,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         // SizedBox(
// //                                         //   width: 10,
// //                                         // ),
// //                                         Text(widget.cartQuantity.toString()),
// //                                         // SizedBox(
// //                                         //   width: 10,
// //                                         // xewx),
// //                                         InkWell(
// //                                           onTap: () {
// //
// //                                             if(widget.cartQuantity<vm.inventory[widget.product.barcode])
// //                                             {
// //                                               updateProduct(widget.product.barcode, 1);
// //                                             }
// //                                             // //print(vm.cart.items.keys.toList());
// //                                             // if(vm.cart.items.keys.toList().isEmpty&&vm.inventory[widget.product.barcode]>0)
// //                                             //   {
// //                                             //     updateProduct(widget.product.barcode, 1);
// //                                             //     return ;
// //                                             //   }
// //                                             // for(var i in vm.cart.items.keys.toList())
// //                                             //   {
// //                                             //     //print(i);
// //                                             //     if(vm.inventory[widget.product.barcode]>0){
// //                                             //       updateProduct(widget.product.barcode, 1);
// //                                             //     }
// //                                             //   }
// //                                             //
// //                                             //vm.updateCart();
// //                                           },
// //                                           child: Container(
// //                                             padding: EdgeInsets.only(
// //                                                 left: 20,
// //                                                 right: 20,
// //                                                 top: 10,
// //                                                 bottom: 10),
// //                                             child: Icon(
// //                                               Icons.add,
// //                                               size: 18.0,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ):SizedBox.shrink(),
// //                           ],
// //                         ),
// //                         // Container(
// //                         //   margin: EdgeInsets.only(top: 10),
// //                         //   child: Divider(
// //                         //     height: 1,
// //                         //     color: Colors.grey,
// //                         //   ),
// //                         // )
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               }
// //           ):Container();
// //         });
// //   }
//   Widget build(BuildContext context) {
//     // return Column(
//     //   children: [
//     //     Card(
//     //       child: Container(
//     //         color: Colors.white,
//     //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     //         child: Column(
//     //           children: [
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //               children: [
//     //                 Expanded(
//     //                   flex: 2,
//     //                   child: Container(
//     //                     margin: EdgeInsets.only(left: 5),
//     //                     child: Column(
//     //                       mainAxisSize: MainAxisSize.min,
//     //                       crossAxisAlignment: CrossAxisAlignment.start,
//     //                       children: [
//     //                         Container(
//     //                           child: Text(
//     //                             "Badam Milk 200 ml-N39",
//     //                             style: TextStyle(fontSize: 18),
//     //                           ),
//     //                         ),
//     //                         Container(
//     //                           child: Text("125g",
//     //                               style: TextStyle(
//     //                                   fontSize: 20, color: Color(0xFF888888))),
//     //                         ),
//     //                         Container(
//     //                           margin: EdgeInsets.only(top: 10),
//     //                           child: Text(
//     //                             "₹" + ("50"),
//     //                             style: TextStyle(
//     //                                 fontSize: 20, color: Color(0xFF3A69DB)),
//     //                           ),
//     //                         ),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 Expanded(
//     //                   flex: 0,
//     //                   child: Column(
//     //                     mainAxisSize: MainAxisSize.min,
//     //                     mainAxisAlignment: MainAxisAlignment.end,
//     //                     children: [
//     //                       SizedBox(
//     //                         height: 20,
//     //                       ),
//     //                       Container(
//     //                         decoration: BoxDecoration(
//     //                           borderRadius: BorderRadius.circular(10),
//     //                           color: Colors.white,
//     //                         ),
//     //                         child: Row(
//     //                           children: <Widget>[
//     //
//     //                             _itemCount!=0?   IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
//     //                             Text(_itemCount.toString()),
//     //                             IconButton(icon: new Icon(Icons.add),onPressed: (){
//     //                               //print("++++++++-${widget.invertoryList}");
//     //                               setState(()=>_itemCount++);})
//     //
//     //                           ],
//     //                         ),
//     //                       ),
//     //
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   ],
//     // );
//     return ListView.builder(
//       scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       itemCount: widget.invertoryList.length,
//       itemBuilder: (context, index) {
//         // return  widget.products[index].productName!= "Work" && widget.products[index].productName != "Play" ?Column(
//         // //print("7777777977+${widget.invertoryList[index]["ProductID"]}");
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               child: Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Container(
//                             margin: EdgeInsets.only(left: 5),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   child: Text(
//                                     widget.invertoryList[index]["ProductName"],
//                                     style: TextStyle(fontSize: 18),
//                                   ),
//                                 ),
//                                 Container(
//                                   child: Text(
//                                       widget.invertoryList[index]["ProductID"],
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Color(0xFF888888))),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 10),
//                                   child: Text(
//                                     "₹" + ("50"),
//                                     style: TextStyle(
//                                         fontSize: 20, color: Color(0xFF3A69DB)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 0,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 child: Row(
//                                   children: <Widget>[
//                                     _itemCount != 0
//                                         ? IconButton(
//                                             icon: new Icon(Icons.remove),
//                                             onPressed: () async {
//                                               await widget.invertoryList[index]
//                                                       ["data"]
//                                                   .forEach((element) async {
//                                                 //print(element);
//
//                                                 //print(
//                                                     "++++++++-${element["SubProductID"]}");
//                                                 //print(
//                                                     "2565464646546546+${widget.invertoryList[index]["data"].length}");
//                                               });
//                                               //print(
//                                                   "++++++++-${widget.invertoryList[index]["data"][0]["SubProductID"]}");
//
//                                               setState(() {
//                                                 Kichprod =
//                                                     widget.invertoryList[index]
//                                                         ["data"];
//                                                 _itemCount--;
//                                               });
//                                               return Kichprod;
//                                             },
//                                           )
//                                         : Container(),
//                                     Text(_itemCount.toString()),
//                                     IconButton(
//                                       icon: Icon(Icons.add),
//                                       onPressed: () async {
//                                         await widget.invertoryList[index]
//                                                 ["data"]
//                                             .forEach((element) async {
//                                           //print(element);
//
//                                           //print(
//                                               "++++++++-${element["SubProductID"]}");
//                                           //print(
//                                               "2565464646546546+${widget.invertoryList[index]["data"].length}");
//                                         });
//                                         //print(
//                                             "++++++++-${widget.invertoryList[index]["data"][0]["SubProductID"]}");
//
//                                         setState(() {
//                                           Kichprod = widget.invertoryList[index]
//                                               ["data"];
//                                           _itemCount++;
//                                         });
//                                         return Kichprod;
//                                         // //print("++++++++-${widget.invertoryList[index]}");+
//                                       },
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void updateProduct(String bacode, int qty) {
//     Completer<int> completer = Completer();
//     vm.updateCart(bacode, qty, completer);
//   }
//
//   @override
//   void dispose() {
//     _quantityEditingController.dispose();
//     super.dispose();
//   }
// }

// class QuantityField extends StatelessWidget {
// //  final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController controller;
//
//   const QuantityField({Key key, this.controller}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       textAlign: TextAlign.center,
//       keyboardType: TextInputType.phone,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(3)
//       ],
//       validator: (input) {
//         var quantity = int.tryParse(input) ?? 0;
//         if (input.length > 0 && quantity < 1) {
//           return "Invalid";
//         } else
//           return null;
//       },
//       decoration: InputDecoration(
//           hintText: "0",
//           contentPadding: EdgeInsets.all(8),
//           border: OutlineInputBorder(gapPadding: 1)),
//     );
// //    );
//   }
// }

// class _ViewModel {
//   final inventory;
//   final Cart cart;
//   final Function(String product, int quantity, Completer<int> completer)
//       updateCart;
//
//   _ViewModel(this.inventory, this.cart, this.updateCart);
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//         store.state.inventoryQuantity,
//         store.state.cart,
//         (product, quantity, completer) =>
//             store.dispatch(UpdateCartAction(product, quantity, completer)));
//   }
// }

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
// import 'dart:async';
//
// import 'package:aavinposfro/actions/actions.dart';
// import 'package:aavinposfro/models/app_state.dart';
// import 'package:aavinposfro/models/indent.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:redux/redux.dart';
//
// class KichenCard extends StatefulWidget {
//   @override
//   _KichenCardState createState() => _KichenCardState();
// }
//
// class _KichenCardState extends State<KichenCard> {
//   _ViewModel vm;
//   TextEditingController _quantityEditingController;
//
//   @override
//   void initState() {
//     // initSetup();
//     super.initState();
//   }
//
//   // Map invertory = {};
//   // initSetup() async {
//   //
//   //   DocumentSnapshot snapshot = (await FirebaseFirestore.instance
//   //       .collection("KitchenProduct")
//   //       .doc("N41")
//   //       .get());
//   //   invertory = snapshot.data();
//   //   //print("777$invertory");
//   //   return invertory;
//   // }
//   int _itemCount1 = 0;
//   int _itemCount2 = 0;
//   int _itemCount3 = 0;
//   int _itemCount4 = 0;
//   int _itemCount5 = 0;
//   int _itemCount6 = 0;
//   int _itemCount7 = 0;
//   int _itemCount8 = 0;
//   int _itemCount9 = 0;
//   int _itemCount10 = 0;
//   int _itemCount11 = 0;
//
//   @override
// //   Widget build(BuildContext context) {
// //     return StoreConnector<AppState, _ViewModel>(
// //         converter: _ViewModel.fromStore,
// //         builder: (context, vm) {
// //           this.vm = vm;
// //           return vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null?StreamBuilder(
// //               stream: null,
// //               builder: (context, snapshot) {
// //                 return Card(
// //                   child: Container(
// //                     color: Colors.white,
// //
// // //            color: Colors.grey[200],
// //
// //                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                     // decoration: BoxDecoration(
// //                     //     color: Color(0xFFF6F6F6),
// //                     //     borderRadius: BorderRadius.only(
// //                     //       topLeft: Radius.circular(20),
// //                     //       topRight: Radius.circular(20),
// //                     //     )),
// //                     child: Column(
// //                       children: [
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             // CachedNetworkImage(
// //                             //   imageUrl: StringUtils.baseurl+widget.product.image,
// //                             //   height: 70,
// //                             //   width: 70,
// //                             //   fit: BoxFit.contain,
// //                             // ),
// //                             vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null?Expanded(
// //                               flex: 2,
// //                               child: Container(
// //                                 margin: EdgeInsets.only(left: 5),
// //                                 child: Column(
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Container(
// //                                       child: Text(
// //                                         widget.product.name,
// //                                         style: TextStyle(fontSize: 18),
// //                                       ),
// //                                     ),
// //                                     Container(
// //                                       child: Text(widget.product.size,
// //                                           style: TextStyle(
// //                                               fontSize: 20, color: Color(0xFF888888))),
// //                                     ),
// //                                     vm.inventory[widget.product.price.toStringAsFixed(2)]!=0.0&&vm.inventory[widget.product.price.toStringAsFixed(2)]!=null&&vm.inventory[widget.product.price.toStringAsFixed(2)]!=0?null:Container(
// //                                       margin: EdgeInsets.only(top: 10),
// //                                       child: Text(
// //                                         "₹" + (widget.product.price.toStringAsFixed(2)),
// //                                         style: TextStyle(
// //                                             fontSize: 20, color: Color(0xFF3A69DB)),
// //                                       ),
// //                                     ),
// //                                     // Container(
// //                                     //   margin: EdgeInsets.only(top: 10),
// //                                     //   child: Text(
// //                                     //     "₹" + (vm.inventory[widget.product.price.toStringAsFixed(2)]!=0.0&&vm.inventory[widget.product.price.toStringAsFixed(2)]!=null?widget.product.price.toStringAsFixed(2):""),
// //                                     //     style: TextStyle(
// //                                     //         fontSize: 20, color: Color(0xFF3A69DB)),
// //                                     //   ),
// //                                     // ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ):SizedBox.shrink(),
// //                             vm.inventory[widget.product.id]!=0&&vm.inventory[widget.product.id]!=null?Expanded(
// //                               flex: 0,
// //                               child: Column(
// //                                 mainAxisSize: MainAxisSize.min,
// //                                 mainAxisAlignment: MainAxisAlignment.end,
// //                                 children: [
// //                                   SizedBox(
// //                                     height: 20,
// //                                   ),
// //                                   Container(
// //                                     decoration: BoxDecoration(
// //                                       borderRadius: BorderRadius.circular(10),
// //                                       color: Color(0xFFEFEFEF),
// //                                     ),
// //                                     child: Row(
// //                                       children: <Widget>[
// //                                         InkWell(
// //                                           onTap: () {
// //                                             updateProduct(widget.product.barcode, -1);
// //                                             //    vm.updateCart(widget.product.barcode, -1);
// //                                           },
// //                                           child: Container(
// //                                             padding: EdgeInsets.only(
// //                                                 left: 20,
// //                                                 right: 20,
// //                                                 top: 10,
// //                                                 bottom: 10),
// //                                             child: Icon(
// //                                               Icons.remove,
// //                                               size: 18.0,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         // SizedBox(
// //                                         //   width: 10,
// //                                         // ),
// //                                         Text(widget.cartQuantity.toString()),
// //                                         // SizedBox(
// //                                         //   width: 10,
// //                                         // xewx),
// //                                         InkWell(
// //                                           onTap: () {
// //
// //                                             if(widget.cartQuantity<vm.inventory[widget.product.barcode])
// //                                             {
// //                                               updateProduct(widget.product.barcode, 1);
// //                                             }
// //                                             // //print(vm.cart.items.keys.toList());
// //                                             // if(vm.cart.items.keys.toList().isEmpty&&vm.inventory[widget.product.barcode]>0)
// //                                             //   {
// //                                             //     updateProduct(widget.product.barcode, 1);
// //                                             //     return ;
// //                                             //   }
// //                                             // for(var i in vm.cart.items.keys.toList())
// //                                             //   {
// //                                             //     //print(i);
// //                                             //     if(vm.inventory[widget.product.barcode]>0){
// //                                             //       updateProduct(widget.product.barcode, 1);
// //                                             //     }
// //                                             //   }
// //                                             //
// //                                             //vm.updateCart();
// //                                           },
// //                                           child: Container(
// //                                             padding: EdgeInsets.only(
// //                                                 left: 20,
// //                                                 right: 20,
// //                                                 top: 10,
// //                                                 bottom: 10),
// //                                             child: Icon(
// //                                               Icons.add,
// //                                               size: 18.0,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ):SizedBox.shrink(),
// //                           ],
// //                         ),
// //                         // Container(
// //                         //   margin: EdgeInsets.only(top: 10),
// //                         //   child: Divider(
// //                         //     height: 1,
// //                         //     color: Colors.grey,
// //                         //   ),
// //                         // )
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               }
// //           ):Container();
// //         });
// //   }
//   Widget build(BuildContext context) {
//     // return Column(
//     //   children: [
//     //     Card(
//     //       child: Container(
//     //         color: Colors.white,
//     //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     //         child: Column(
//     //           children: [
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //               children: [
//     //                 Expanded(
//     //                   flex: 2,
//     //                   child: Container(
//     //                     margin: EdgeInsets.only(left: 5),
//     //                     child: Column(
//     //                       mainAxisSize: MainAxisSize.min,
//     //                       crossAxisAlignment: CrossAxisAlignment.start,
//     //                       children: [
//     //                         Container(
//     //                           child: Text(
//     //                             "Badam Milk 200 ml-N39",
//     //                             style: TextStyle(fontSize: 18),
//     //                           ),
//     //                         ),
//     //                         Container(
//     //                           child: Text("125g",
//     //                               style: TextStyle(
//     //                                   fontSize: 20, color: Color(0xFF888888))),
//     //                         ),
//     //                         Container(
//     //                           margin: EdgeInsets.only(top: 10),
//     //                           child: Text(
//     //                             "₹" + ("50"),
//     //                             style: TextStyle(
//     //                                 fontSize: 20, color: Color(0xFF3A69DB)),
//     //                           ),
//     //                         ),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 Expanded(
//     //                   flex: 0,
//     //                   child: Column(
//     //                     mainAxisSize: MainAxisSize.min,
//     //                     mainAxisAlignment: MainAxisAlignment.end,
//     //                     children: [
//     //                       SizedBox(
//     //                         height: 20,
//     //                       ),
//     //                       Container(
//     //                         decoration: BoxDecoration(
//     //                           borderRadius: BorderRadius.circular(10),
//     //                           color: Colors.white,
//     //                         ),
//     //                         child: Row(
//     //                           children: <Widget>[
//     //
//     //                             _itemCount!=0?   IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
//     //                             Text(_itemCount.toString()),
//     //                             IconButton(icon: new Icon(Icons.add),onPressed: (){
//     //                               //print("++++++++-${widget.invertoryList}");
//     //                               setState(()=>_itemCount++);})
//     //
//     //                           ],
//     //                         ),
//     //                       ),
//     //
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   ],
//     // );
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Card(
//           child: Container(
//             color: Colors.white,
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 5),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               child: Text(
//                                 "Badam Milk 200 ml",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ),
//                             Container(
//                               child: Text("N39",
//                                   style: TextStyle(
//                                       fontSize: 20, color: Color(0xFF888888))),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 10),
//                               child: Text(
//                                 "₹" + ("50"),
//                                 style: TextStyle(
//                                     fontSize: 20, color: Color(0xFF3A69DB)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 0,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                             ),
//                             child: Row(
//                               children: <Widget>[
//                                 _itemCount1 != 0
//                                     ? IconButton(
//                                         icon: new Icon(Icons.remove),
//                                         onPressed: () {
//                                           setState(() => _itemCount1--);
//                                         })
//                                     : Container(),
//                                 Text(_itemCount1.toString()),
//                                 IconButton(
//                                     icon: Icon(Icons.add),
//                                     onPressed: () {
//                                       // //print("++++++++-${widget.invertoryList[index]}");+
//                                       setState(() => _itemCount1++);
//                                     })
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Card(
//           child: Container(
//             color: Colors.white,
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 5),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               child: Text(
//                                 "Pista Milk 200 ml",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ),
//                             Container(
//                               child: Text("N41",
//                                   style: TextStyle(
//                                       fontSize: 20, color: Color(0xFF888888))),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 10),
//                               child: Text(
//                                 "₹" + ("50"),
//                                 style: TextStyle(
//                                     fontSize: 20, color: Color(0xFF3A69DB)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 0,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                             ),
//                             child: Row(
//                               children: <Widget>[
//                                 _itemCount2 != 0
//                                     ? IconButton(
//                                         icon: new Icon(Icons.remove),
//                                         onPressed: () {
//                                           setState(() => _itemCount2--);
//                                         })
//                                     : Container(),
//                                 Text(_itemCount2.toString()),
//                                 IconButton(
//                                     icon: Icon(Icons.add),
//                                     onPressed: () {
//                                       // //print("++++++++-${widget.invertoryList[index]}");+
//                                       setState(() {
//                                         setState(() => _itemCount2++);
//                                       });
//                                     })
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Card(
//           child: Container(
//             color: Colors.white,
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 5),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               child: Text(
//                                 "Hot Milk",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ),
//                             Container(
//                               child: Text("H01",
//                                   style: TextStyle(
//                                       fontSize: 20, color: Color(0xFF888888))),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 10),
//                               child: Text(
//                                 "₹" + ("50"),
//                                 style: TextStyle(
//                                     fontSize: 20, color: Color(0xFF3A69DB)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 0,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                             ),
//                             child: Row(
//                               children: <Widget>[
//                                 _itemCount3 != 0
//                                     ? IconButton(
//                                         icon: new Icon(Icons.remove),
//                                         onPressed: () =>
//                                             setState(() => _itemCount3--),
//                                       )
//                                     : Container(),
//                                 Text(_itemCount3.toString()),
//                                 IconButton(
//                                     icon: Icon(Icons.add),
//                                     onPressed: () {
//                                       // //print("++++++++-${widget.invertoryList[index]}");+
//                                       setState(() => _itemCount3++);
//                                     })
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Card(
//           child: Container(
//             color: Colors.white,
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 5),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               child: Text(
//                                 "Hot Milk (Badam)",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ),
//                             Container(
//                               child: Text("H02",
//                                   style: TextStyle(
//                                       fontSize: 20, color: Color(0xFF888888))),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 10),
//                               child: Text(
//                                 "₹" + ("50"),
//                                 style: TextStyle(
//                                     fontSize: 20, color: Color(0xFF3A69DB)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 0,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                             ),
//                             child: Row(
//                               children: <Widget>[
//                                 _itemCount4 != 0
//                                     ? IconButton(
//                                         icon: new Icon(Icons.remove),
//                                         onPressed: () =>
//                                             setState(() => _itemCount4--),
//                                       )
//                                     : Container(),
//                                 Text(_itemCount4.toString()),
//                                 IconButton(
//                                     icon: Icon(Icons.add),
//                                     onPressed: () {
//                                       // //print("++++++++-${widget.invertoryList[index]}");+
//                                       setState(() => _itemCount4++);
//                                     })
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void updateProduct(String bacode, int qty) {
//     Completer<int> completer = Completer();
//     vm.updateCart(bacode, qty, completer);
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
//     return TextFormField(
//       controller: controller,
//       textAlign: TextAlign.center,
//       keyboardType: TextInputType.phone,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(3)
//       ],
//       validator: (input) {
//         var quantity = int.tryParse(input) ?? 0;
//         if (input.length > 0 && quantity < 1) {
//           return "Invalid";
//         } else
//           return null;
//       },
//       decoration: InputDecoration(
//           hintText: "0",
//           contentPadding: EdgeInsets.all(8),
//           border: OutlineInputBorder(gapPadding: 1)),
//     );
// //    );
//   }
// }
//
// class _ViewModel {
//   final inventory;
//   final Cart cart;
//   final Function(String product, int quantity, Completer<int> completer)
//       updateCart;
//
//   _ViewModel(this.inventory, this.cart, this.updateCart);
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel(
//         store.state.inventoryQuantity,
//         store.state.cart,
//         (product, quantity, completer) =>
//             store.dispatch(UpdateCartAction(product, quantity, completer)));
//   }
// }
//
// //  Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: <Widget>[
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: <Widget>[
// //                         Text(
// //                           widget.product.name,
// //                           style: Theme.of(context).textTheme.headline5,
// //                         ),
// //                         SizedBox(
// //                           height: 4,
// //                         ),
// //                         Wrap(
// //                           spacing: 8,
// //                           children: <Widget>[
// //                             Tag(
// //                               label: Text(
// //                                 widget.product.id,
// //                                 style: Theme.of(context)
// //                                     .textTheme
// //                                     .bodyText1
// //                                     .copyWith(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: Colors.white),
// //                               ),
// //                             ),
// //                             Tag(
// //                               label: Text("₹",
// //                                   style: Theme.of(context)
// //                                       .textTheme
// //                                       .bodyText1
// //                                       .copyWith(
// //                                           fontSize: 12,
// //                                           fontWeight: FontWeight.bold,
// //                                           color: Colors.white)),
// //                               child: Text(widget.product.price.toString(),
// //                                   style: Theme.of(context)
// //                                       .textTheme
// //                                       .bodyText1
// //                                       .copyWith(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.bold,
// //                                       )),
// //                               color: Colors.blue[400],
// //                             ),
// //                             if (widget.stockQuantity > 0)
// //                               Tag(
// //                                 label: Icon(
// //                                   Icons.store_mall_directory,
// //                                   color: Colors.white,
// //                                   size: 14,
// //                                 ),
// //                                 child: Text(widget.stockQuantity.toString(),
// //                                     style: Theme.of(context)
// //                                         .textTheme
// //                                         .bodyText1
// //                                         .copyWith(
// //                                           fontSize: 12,
// //                                           fontWeight: FontWeight.bold,
// //                                         )),
// //                                 color: Colors.green[400],
// //                               )
// //                           ],
// //                         ),
//
// //                       ],
// //                     ),
// //                     Column(
// //                       children: <Widget>[
// //                         Container(
// //                           margin: EdgeInsets.only(right: 10),
// //                           height: 50,
// //                           decoration: BoxDecoration(
// //                               color: Colors.grey,
// //                               borderRadius:
// //                               BorderRadius.all(
// //                                   Radius.circular(10))),
// //                           child: Row(
// //                             mainAxisAlignment:
// //                             MainAxisAlignment.spaceBetween,
// //                             children: <Widget>[
// //                               IconButton(
// //                                 padding: EdgeInsets.all(0),
// //                                 onPressed: () {
// //                                   vm.updateCart(widget.product.barcode,-1);
//
// //                                 },
// //                                 icon: Icon(Icons.remove),
// //                               ),
// //                               Text(widget.cartQuantity.toString()
// //                                   .toString(),
// //                                   style: TextStyle(
// //                                     fontWeight: FontWeight.w500,
// //                                     color: Colors.black,
//
// //                                   )),
// //                               IconButton(
// //                                 padding: EdgeInsets.all(0),
// //                                 onPressed: () {
// //                                   vm.updateCart(widget.product.barcode,1);
// //                                 },
// //                                 icon: Icon(Icons.add),
// //                               )
// //                             ],
// //                           ),
// //                         ),
// // //                        Container(
// // //                          width: 64,
// // //                          child: Text(
// // //                            widget.cartQuantity.toString()
// // //                          )
// // //                        ),
// //                         if (widget.cartQuantity > 0)
// //                           Column(
// //                             children: <Widget>[
// //                               SizedBox(
// //                                 height: 4,
// //                               ),
// //                               Text("₹ ${widget.product.price * widget.cartQuantity}")
// //                             ],
//
// //                           ),
//
// //                       ],
//
// //                     )
// //                   ],
// //                 ),
