import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/routes.dart';
import 'package:aavinposfro/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class OrdersViewCard extends StatefulWidget {
  //int order_quantity;
  String order_title;
  double order_total_price;
  int order_created_date;
  PointOfSaleOrder indentOrder;

  OrdersViewCard(
      {this.order_title,
      this.order_total_price,
      this.order_created_date,
      this.indentOrder});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrdersViewCardState();
  }
}

class OrdersViewCardState extends State<OrdersViewCard> {
  int radioItem = 0;
  _ViewModel vm;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          this.vm = vm;
          return InkWell(
            onTap: () {
              //  //print(widget.indentOrder.productList.toString());
              vm.updatePointOfSaleOrder(widget.indentOrder);
              vm.navigation(AppRoutes.orderdetail);
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
//      elevation: 4,
//      shape: RoundedRectangleBorder(
//        side: BorderSide(color: Colors.white, width: 1),
//        borderRadius: BorderRadius.circular(20),
//      ),
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.02, 0.02],
                  colors: [Colors.white, Colors.white],
                ),
                borderRadius: BorderRadius.all(Radius.circular(22)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.6), blurRadius: 5.0),
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Order: " + widget.order_title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
//                     Container(
//                         height: 37,
//                         margin: EdgeInsets.only(left: 10, right: 0, top: 5),
//                         child:  RaisedButton(
//                               onPressed: () {
//                              //   debugPrint(widget.indentOrder.totalItem.toString());
//                                //  vm.navigateOrderDetail(widget.indentOrder);
//                               },
//                               color:Theme.of(context).primaryColor,
//                               child: Row(
//                                 children: <Widget>[
//                                   Center(
//                                     //alignment: Alignment.center,
//                                     child: Text(
//                                       'View Details',
//                                       style: TextStyle(
//
//                                           fontSize: 12,
//                                           color: Colors.white),
//                                     ),
//                                   ),
// //                                  Container(
// //                                    margin: EdgeInsets.only(left: 10),
// //                                    child:Icon(
// //                                      Icons.arrow_right,
// //                                      color: Colors.white,
// //                                    ),
// //                                  )
//                                 ],
//                               ),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                             ))
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 5, right: 10),
                      child: Text(
                        DateFormat("dd MMM yyyy hh:mm a").format(
                            DateTime.fromMillisecondsSinceEpoch(
                                widget.order_created_date)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 5),
                    // Divider(
                    //   height: 1,
                    // ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Text(
                              "₹ " +
                                  widget.order_total_price.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorUtils.lightBlue,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            alignment: Alignment.center,
                            child: Text(
                              'View Details',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                    )
                  ]),
            ),
          );
        });
  }
}

class _ViewModel {
  final Function(String route) navigation;
  final Function(PointOfSaleOrder pointOfSaleOrder) updatePointOfSaleOrder;

  //final Function(IndentOrder indentOrder) navigateOrderDetail;

  _ViewModel(this.navigation, this.updatePointOfSaleOrder);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        (route) => store.dispatch(NavigateAction(route)),
        (pointofsalfeorder) =>
            store.dispatch(UpdatePosOrder(pointofsalfeorder)));
  }
}
