import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/presentation/widgets/order/cart_items_list.dart';
import 'package:aavinposfro/presentation/widgets/text_with_tag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class OrderHistoryList extends StatelessWidget {
//   final List<Order> orders;
//   final Function onViewProductsPressed;
//
//   const OrderHistoryList(
//       {Key key, this.orders, @required this.onViewProductsPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
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

// class OrderRow extends StatelessWidget {
//   final Order order;
//
//   const OrderRow(
//       this.order, {
//         Key key,
//       }) : super(key: key);
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
//                         color: Colors.grey,
//                       )),
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
//                         color: Colors.grey,
//                       )),
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
class BillDetails extends StatefulWidget {


  @override
  State<BillDetails> createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Bill Details"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("POS_Order")
        // .where('Completed', isEqualTo: "No")
        // .where('WF_User_ID', isEqualTo: widget.Number)
        //.where('manager', isEqualTo: rej)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data.docs.map(
                  (document) {
                // //print("${widget.Number}");
                // //print(document['Project_Name']);
                // //print("$UserInputs()");
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Order ID",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  document['Order_ID'],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Store Code",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  document["Store_Code"],
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Expanded(
                          //       flex: 4,
                          //       child: Text(
                          //         "Time",
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 15),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       flex: 2,
                          //       child: Text(
                          //         ':',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 15),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       flex: 4,
                          //       child: Text(
                          //         document['Time'],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          ElevatedButton(
                            style: TextButton.styleFrom(

                              backgroundColor:Colors.blue,
                            ),
                            onPressed: () async {
                              // Name = "${document['Project_Name']}";


                              // //print(Name);

                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => UpdateForm(
                              //       Project_Name: Name,
                              //
                              //       Issue_Attachement:
                              //       document['Issue_Attachement'],
                              //       Issue_Description:
                              //       document['Issue_Description'],
                              //       Completed: document['Completed'],
                              //       Work_Description:
                              //       document['Work_Description'],
                              //       Work_Proof: document['Work_Proof'],
                              //     ),
                              //   ),
                              // );
                            },
                            child: Text('View Details'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
