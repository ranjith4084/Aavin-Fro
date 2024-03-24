import 'dart:convert';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

import '../../../Settings/Profile.dart';

class DispatchedList extends StatefulWidget {
  List dispatchList;
  Map idQtyMap;
  var shipmentID;
String parlourID;
List valueList;
List keylist;


  DispatchedList({this.dispatchList,this.idQtyMap,this.shipmentID,this.parlourID,this.valueList,this.keylist});
  @override
  _DispatchedListState createState() => _DispatchedListState();
}

class _DispatchedListState extends State<DispatchedList> {
  List kitchenData=[];
  _ViewModel _vm;
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  getKitchenData()async
  {
    var data =(await  _ref.collection("DispatchedData").get()).docs.map((element) {
      return element.data();
    }).toList();
    setState(() {
      kitchenData=data;
    });
    // //print(kitchenData);
  }
  _showDialog()
  {
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure, you want to add the data ?"),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("No")),
        TextButton(
            onPressed: ()async{
              final formattedStr = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
              var exacttime = DateFormat.jm().format(DateTime.now());

              FirebaseFirestore _firestore = FirebaseFirestore.instance;
              await _firestore.collection('Dispatch_Data_entries').add({
                "Date": formattedStr,
                "Time": exacttime,
                'Created_At': FieldValue.serverTimestamp(),
                "Shipment_ID": widget.shipmentID,
                "Parlour_ID": widget.parlourID,

                 "Map_product": widget.idQtyMap,
              }).then((value) async {
                await _firestore
                    .collection('Dispatch_Data_entries')
                    .doc(value.id)
                    .update({"Document_Id": value.id});
                // //print("${value.id}");
                var document_id = "${value.id}";
                // //print("$document_id");
                // ignore: unnecessary_statements
                return document_id;
              });
               // //print(widget.dispatchList);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) =>
                      Profile()));

              //////////////////////////////////////////////////////////////////olds
              Map<String,dynamic> temp={};
              Map tempInventory = _vm.inventoryQuantity;
              for(String i in widget.idQtyMap.keys)
              {
                temp[i]=FieldValue.increment(widget.idQtyMap[i].floor());
                tempInventory[i]= (tempInventory[i]??0) +widget.idQtyMap[i].floor() ;

              }
              setState(() {
                _vm.updateInventory(tempInventory);
              });
              final formatteddate = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
              // //print("test123${tempInventory}");
              var headers = {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Cookie': 'JSESSIONID=DB6FABE960519CD04196D1AADEBA272E.tomcat1'
              };

              var request = http.Request('POST', Uri.parse('https://idms-fed.aavin.tn.gov.in/rest/posApi/postPOSReceiptAckEntry'));
              // //print("000000 The Username  - ${_vm.storedetails.storeCode} and parlour id - ${_vm.storedetails.parlourId} 0000000");
  if(_vm.storedetails.storeCode=="P171"||_vm.storedetails.storeCode=="P168") {
    request.bodyFields = {
      'username':"${_vm.storedetails.storeCode}_PM",
      'password': 'Aavin123',
      'tenantId': 'aavin-fed',
      'parlourId': _vm.storedetails.parlourId,
      'ackProdQtyDetails': '${widget.idQtyMap}',
      'shipmentId': '${widget.shipmentID}',
      'receiptDate': formatteddate
    };
  }
  else{


              request.bodyFields = {
                'username': _vm.storedetails.storeCode,
                'password': 'Aavin123',
                'tenantId': 'aavin-fed',
                'parlourId': _vm.storedetails.parlourId,
                'ackProdQtyDetails': '${widget.idQtyMap}',
                'shipmentId': '${widget.shipmentID}',
                'receiptDate': formatteddate
              };}
              request.headers.addAll(headers);

              http.StreamedResponse response = await request.send();

              if (response.statusCode == 200) {
                // //print(await response.stream.bytesToString());
              }
              else {
                // //print(response.reasonPhrase);
              }
              FirebaseFirestore ref = FirebaseFirestore.instance;
              await ref.collection("InventoryChanges").doc(_vm.storedetails.storeCode).update(temp);
              setState(() {
                widget.dispatchList=[];
                widget.idQtyMap={};
                widget.idQtyMap={};
              });

              //////////////////////////////////////////////////////////////////old
            }, child: Text("Yes"))
      ],
    ));
  }
  @override
  void initState() {
    super.initState();
    getKitchenData();
  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          this._vm = vm;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.playlist_add_outlined),
              onPressed: () {
                //print(_vm.inventoryQuantity);
                _showDialog();
              },
            ),
            appBar: AppBar(
              title: Text("Dispatched Product List"),
            ),
            body: ListView.builder(
              itemCount: widget.dispatchList.length,
              itemBuilder: (context,index){
                //print("++++++++++++++${widget.dispatchList}");
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    // title: Text(widget.dispatchList[index]["name"].toString()??""),
                    title: Text(widget.keylist[index].toString()??"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                    trailing: Text(widget.valueList[index].toString()??"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                  ),
                );
              },),
          );});
  }
}

class _ViewModel {
  final List dispatchList;
  final Map inventoryQuantity;
  final Function(Map inventory) updateInventory;
  final StoreDetails storedetails;
  _ViewModel(
      this.dispatchList,
      this.inventoryQuantity,
      this.updateInventory,
      this.storedetails
      );
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(

        store.state.dispatchedList,
        store.state.inventoryQuantity,
            (inventory) => store.dispatch(UpdateInventoryQuantity(inventoryQuantity: inventory)),
        store.state.storeDetails
    );
  }
}