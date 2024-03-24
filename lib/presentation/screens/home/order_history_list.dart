// import 'package:aavinposfro/models/order.dart';
// import 'package:aavinposfro/presentation/widgets/order/cart_items_list.dart';
// import 'package:aavinposfro/presentation/widgets/text_with_tag.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class OrderHistoryList extends StatelessWidget {
//
//   final List<Order> orders;
//   final Function onViewProductsPressed;
//
//   const OrderHistoryList(
//       {Key key, this.orders, @required this.onViewProductsPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //print(orders);
//     if (this.orders != null && this.orders.isNotEmpty) {
//       return ListView.builder(
//           shrinkWrap: true,
//           itemCount: this.orders.length,
//           itemBuilder: (context, i) {
//             return OrderRow(this.orders[i]);
//           });
//     } else {
//       return EmptyOrderHistoryInformation(
//           onViewProductsPressed: onViewProductsPressed);
//     }
//   }
// }
//
// class OrderRow extends StatelessWidget {
//   final Order order;
//
//   const OrderRow(
//     this.order, {
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Card(
//         color: Colors.grey[100],
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Text(
//                         "Order ID : ",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Colors.grey[700]),
//                       ),
//                       Text(
//                         order.id,
//                         style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                       ),
//                     ],
//                   ),
//                   TextWithTag(
//                     text: order.getOrderStatusAsString(),
//                     backgoundColor: Colors.grey,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 "Order Placed On ${order.timestamp.toLocal().toString()}",
//                 style: TextStyle(fontSize: 12),
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Expanded(
//                       child: Divider(
//                     color: Colors.grey,
//                   )),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 16, top: 0, right: 16, bottom: 0),
//                     child: Text(
//                       "Order Summary".toUpperCase(),
//                       style: TextStyle(),
//                     ),
//                   ),
//                   Expanded(
//                       child: Divider(
//                     color: Colors.grey,
//                   )),
//                 ],
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               CartItemsList(
//                 items: this.order.cart.items,
//               ),
//               OrderTotalContainer(this.order)
// //              ProductsList(
// //                products: order.products,
// //              ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class EmptyOrderHistoryInformation extends StatelessWidget {
//   final Function onViewProductsPressed;
//
//   const EmptyOrderHistoryInformation(
//       {Key key, @required this.onViewProductsPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Icon(
//           Icons.store,
//           size: 72,
//           color: Colors.grey[300],
//         ),
//         SizedBox(height: 16),
//         Text("You've not placed any orders yet."),
//         SizedBox(height: 16),
//         RaisedButton(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(Icons.add_shopping_cart),
//               SizedBox(
//                 width: 16,
//               ),
//               Text("View Products")
//             ],
//           ),
//           onPressed: this.onViewProductsPressed,
//         )
//       ],
//       mainAxisAlignment: MainAxisAlignment.center,
//     );
//   }
// }
// class BillDetails extends StatefulWidget {
//
//
//   @override
//   State<BillDetails> createState() => _BillDetailsState();
// }
//
// class _BillDetailsState extends State<BillDetails> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         title: Text("Bill Details"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("POS_Order")
//             // .where('Completed', isEqualTo: "No")
//             // .where('WF_User_ID', isEqualTo: widget.Number)
//         //.where('manager', isEqualTo: rej)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//
//           return ListView(
//             children: snapshot.data.docs.map(
//                   (document) {
//                 // //print("${widget.Number}");
//                 // //print(document['Project_Name']);
//                 // //print("$UserInputs()");
//                 return Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       border: Border.all(
//                         color: Colors.black,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 flex: 4,
//                                 child: Text(
//                                   "Date",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   ':',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 4,
//                                 child: Text(
//                                   document['Date'],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 flex: 4,
//                                 child: Text(
//                                   "Time",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   ':',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 4,
//                                 child: Text(
//                                   document["Time"],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // Row(
//                           //   crossAxisAlignment: CrossAxisAlignment.center,
//                           //   children: [
//                           //     Expanded(
//                           //       flex: 4,
//                           //       child: Text(
//                           //         "Time",
//                           //         style: TextStyle(
//                           //             fontWeight: FontWeight.bold,
//                           //             fontSize: 15),
//                           //       ),
//                           //     ),
//                           //     Expanded(
//                           //       flex: 2,
//                           //       child: Text(
//                           //         ':',
//                           //         style: TextStyle(
//                           //             fontWeight: FontWeight.bold,
//                           //             fontSize: 15),
//                           //       ),
//                           //     ),
//                           //     Expanded(
//                           //       flex: 4,
//                           //       child: Text(
//                           //         document['Time'],
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           FlatButton(
//                             color: Colors.blue,
//                             onPressed: () async {
//                               // Name = "${document['Project_Name']}";
//
//
//                               // //print(Name);
//
//                               // Navigator.of(context).push(
//                               //   MaterialPageRoute(
//                               //     builder: (context) => UpdateForm(
//                               //       Project_Name: Name,
//                               //
//                               //       Issue_Attachement:
//                               //       document['Issue_Attachement'],
//                               //       Issue_Description:
//                               //       document['Issue_Description'],
//                               //       Completed: document['Completed'],
//                               //       Work_Description:
//                               //       document['Work_Description'],
//                               //       Work_Proof: document['Work_Proof'],
//                               //     ),
//                               //   ),
//                               // );
//                             },
//                             child: Text('View Details'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../../routes.dart';
import 'package:date_time_picker/date_time_picker.dart';


class OrderHistoryScreen extends StatefulWidget {
  @override
  OrderHistoryScreenState createState() => OrderHistoryScreenState();
}

class OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  _ViewModel _vm;
  String selectedDate="";
  var cashAmount=0.0;
  var cardAmount=0.0;
  var totalAmount=0.0;
  List<PointOfSaleOrder> pos=[];
  List<PointOfSaleOrder> temp=[];
  @override
  void initState() {
    super.initState();
  }
  sortData(selectedDate)
  {
    cashAmount=0.0;
    cardAmount=0.0;
    List<PointOfSaleOrder> dummy=[];
    Future.forEach(temp,(element) {
      if(element.Created_At.toString().substring(0,10)==selectedDate||selectedDate=="")
      {
        if(element.paymentMethod==2)
        {
          cardAmount=cardAmount+element.total;
        }
        if(element.paymentMethod==1)
        {
          cashAmount=cashAmount+element.total;
        }
        dummy.add(element);
      }
    });
    dummy.sort((a,b) => b.Created_At.compareTo(a.Created_At));
    setState(() {
      pos=dummy;
    });
  }
  onPress(){
    Navigator.of(context).pop();
    // _vm.back();
  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      onInit: (store)async{

        await store.dispatch(new FetchOrder());
        setState(() {
          temp=store.state.posList;
        });
        sortData(selectedDate);

      },
      builder: (context, vm) {
        this._vm = vm;
        return Scaffold(
          appBar: AppBar(
            title: Text(
                "Order History"
            ),
            leading:new IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: onPress,
            ),
            backgroundColor:
            Theme.of(context).primaryColor,
//            actions: <Widget>[
//              IconButton(
//                icon: Icon(Icons.search),
//                onPressed: () {
//                  setState(() {
//                    _isSearching = true;
//                  });
//                },
//              ),
//              PopupMenuButton<String>(
//                onSelected: (value) {
//                  switch (value) {
//                    case  'Order History':
//                      vm.orderhistory();
//                      break;
//                    case 'Logout':
//                      vm.signOut();
//                      break;
//                    case 'Settings':
//                      break;
//                    default:
//                      break;
//                  }
//                },
//                itemBuilder: (BuildContext context) {
//                  return {'Order History', 'Settings', 'Logout'}
//                      .map((String choice) {
//                    return PopupMenuItem<String>(
//                      value: choice,
//                      child: Text(
//                        choice,
//                        style: Theme.of(context).textTheme.headline5,
//                      ),
//                    );
//                  }).toList();
//                },
//              ),
//            ],
////            bottom: _isSearching
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
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // SizedBox(height: 10,),
                // Expanded(
                //   flex: 1,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Container(
                //           child: Row(
                //             children: [
                //               Expanded(
                //                 flex:1,
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Text("Date :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                //                   )
                //               ),
                //               Expanded(
                //                 flex: 5,
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: DateTimePicker(
                //
                //                     initialValue: '',
                //                     firstDate: DateTime(2000),
                //                     lastDate: DateTime(2100),
                //                     //dateLabelText: selectedDate==""?'Date':"",
                //                     // fieldHintText: "date",
                //                     dateHintText: "Select a date to filter",
                //                     onChanged: (val){
                //                       sortData(val);
                //                       setState(() {
                //                         selectedDate=val;
                //
                //                       });
                //
                //                     },
                //                     validator: (val) {
                //                       //print(val);
                //                       return null;
                //                     },
                //                     onSaved: (val){
                //
                //                     },
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(20),
                //             color: Colors.white,
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.grey[300],
                //                 offset: const Offset(
                //                   5.0,
                //                   5.0,
                //                 ),
                //                 blurRadius: 10.0,
                //                 spreadRadius: 2.0,
                //               ), //BoxShadow
                //               BoxShadow(
                //                 color: Colors.white,
                //                 offset: const Offset(0.0, 0.0),
                //                 blurRadius: 0.0,
                //                 spreadRadius: 0.0,
                //               ), //BoxShadow
                //             ],
                //           ),
                //
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Expanded(
                //   flex: 1,
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: Container(
                //             height: 70,
                //             alignment: Alignment.center,
                //             child: Text("Card amount : Rs. ${cardAmount.toStringAsFixed(2)}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //               color: Colors.white,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey[300],
                //                   offset: const Offset(
                //                     5.0,
                //                     5.0,
                //                   ),
                //                   blurRadius: 10.0,
                //                   spreadRadius: 2.0,
                //                 ), //BoxShadow
                //                 BoxShadow(
                //                   color: Colors.white,
                //                   offset: const Offset(0.0, 0.0),
                //                   blurRadius: 0.0,
                //                   spreadRadius: 0.0,
                //                 ), //BoxShadow
                //               ],
                //             ),
                //
                //           )),
                //       SizedBox(width: 5,),
                //       Expanded(
                //           child: Container(
                //             height: 70,
                //             alignment: Alignment.center,
                //             child: Text("Cash amount : Rs. ${cashAmount.toStringAsFixed(2)}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //               color: Colors.white,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey[300],
                //                   offset: const Offset(
                //                     5.0,
                //                     5.0,
                //                   ),
                //                   blurRadius: 10.0,
                //                   spreadRadius: 2.0,
                //                 ), //BoxShadow
                //                 BoxShadow(
                //                   color: Colors.white,
                //                   offset: const Offset(0.0, 0.0),
                //                   blurRadius: 0.0,
                //                   spreadRadius: 0.0,
                //                 ), //BoxShadow
                //               ],
                //             ),
                //
                //           )),
                //
                //
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Expanded(
                //   flex: 1,
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: Container(
                //             height: 70,
                //             alignment: Alignment.center,
                //             child: Text("Total amount : Rs. ${(cashAmount+cardAmount).toStringAsFixed(2)}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //               color: Colors.white,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey[300],
                //                   offset: const Offset(
                //                     5.0,
                //                     5.0,
                //                   ),
                //                   blurRadius: 10.0,
                //                   spreadRadius: 2.0,
                //                 ), //BoxShadow
                //                 BoxShadow(
                //                   color: Colors.white,
                //                   offset: const Offset(0.0, 0.0),
                //                   blurRadius: 0.0,
                //                   spreadRadius: 0.0,
                //                 ), //BoxShadow
                //               ],
                //             ),
                //
                //           ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                Expanded(
                    flex: 1,
                    child: Center(child: Text("Order History",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),))
                ),
                Expanded(
                    flex:8,
                    child: OrderList(pos)),
              ],
            ),
          ),
        );
      },
    );
  }
// List<IndentOrder> get _indentHistory {
//   //debugPrint(this._vm.products.toString());
//   return this._vm.orderHistoryAry!=null?this._vm.orderHistoryAry:new List<IndentOrder>();
//
// }
}
class _ViewModel {
  final bool isLoading;
  final User user;
  final Order order;
  final Stock stock;
  final List<Product> products;
  final List<PointOfSaleOrder>orderHistoryAry;
  final Cart cart;

  final int phoneNumber;
  final Function() back;
  final Function() initStockEdit;
  final Function() signOut;
  final Function() orderhistory;
  final Function() fetchIndentOrder;

  final Function() resetIndentOrder;


  _ViewModel(this.isLoading, this.user, this.order, this.stock, this.products,
      this.cart, this.back, this.initStockEdit, this.signOut,this.phoneNumber,this.orderhistory,this.fetchIndentOrder,
      this.orderHistoryAry
      ,this.resetIndentOrder);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      store.state.isLoading,
      store.state.currentUser,
      store.state.order,
      store.state.stock,
      store.state.products,
      store.state.cart,
          () => store.dispatch(NavigateAction(AppRoutes.home)),
          () => store.dispatch(InitStockEditAction()),
          () => store.dispatch(AuthSignOutAction()),
      store.state.phoneNumber,
          () => store.dispatch(NavigateAction(AppRoutes.orderhistory)),
          () => store.dispatch(FetchIndentOrder()),
      store.state.posList,
          () => store.dispatch(OnUpdateIndentOrder()),
    );
  }
}


