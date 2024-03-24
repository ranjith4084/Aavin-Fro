import 'package:aavinposfro/presentation/BillCancel/viewdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../middleware/app_middleware.dart';
import '../../utils/colors_utils.dart';

class BillCancel extends StatefulWidget {
  const BillCancel({Key key}) : super(key: key);

  @override
  State<BillCancel> createState() => _BillCancelState();
}

class _BillCancelState extends State<BillCancel> {
  @override
  onPress() {
    Navigator.of(context).pop();
    // _vm.back();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Bill Status")),
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: onPress,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("POS_Order")
        .where("Store_Code", isEqualTo: storeCode)
        //     .orderBy('Created_At', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
           print("++++++++++${snapshot.data.docs.length}");

          return snapshot.data.docs.length!=0 ?
          ListView(
            children: snapshot.data.docs.map(
              (document) {
                return InkWell(
                  onTap: () {
                    // //print(document['Products']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillDetailScreen(
                          order_Products: document['Products'],
                          order_Status: document['order_Status'],
                          order_referenceId: document['referenceId'],
                          order_SubTotal: document['Order_SubTotal'],
                          order_Cgst: document['Order_Cgst'],
                          order_Sgst: document['Order_Sgst'],
                          order_Total: document['Order_Total'],
                            order_Document_Id: document['Document_Id'],

                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
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
                            color: Colors.grey.withOpacity(.6),
                            blurRadius: 5.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Order: " + document['Order_ID'],
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ]),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 10, top: 5, right: 10),
                            child: Text(
                              "Date: " +
                                  document['Date'] +
                                  " Time: " +
                                  document['Time'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10, right: 10),
                                child: Stack(children: <Widget>[
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: document['order_Status'] == "1"
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        document['order_Status'] == "1"
                                            ? "Booked"
                                            : "Canceled",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10, right: 10),
                                child: Stack(children: <Widget>[
                                  Container(
                                    child: Text(
                                      "₹ " + document['Total_Item'].toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ColorUtils.lightBlue,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
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
              },
            ).toList(),
          ):Center(child: Text("No items found."));
        },
      ),
    );
  }
}
