import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class InwardList extends StatefulWidget {
  @override
  _InwardListState createState() => _InwardListState();
}

class _InwardListState extends State<InwardList> {
  List kitchenData=[];
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  getKitchenData()async
  {
    var data =(await  _ref.collection("InwardEntries").get()).docs.map((element) {
      return element.data();
    }).toList();
    setState(() {
      kitchenData=data;
    });
    //print(kitchenData);
  }
  @override
  void initState() {
    super.initState();
    getKitchenData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inward Form List"),
      ),
      body: ListView.builder(
          itemCount: kitchenData.length,
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(kitchenData[index]["Product_name"]??""),
                leading: Text(kitchenData[index]["Product_ID"]??"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                trailing: Text(kitchenData[index]["Quantity"]+ " nos"??"" ,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                subtitle: Text(DateTime.fromMicrosecondsSinceEpoch(kitchenData[index]["Date"].seconds*1000000).toString()??""),
              ),
            );
          },),
    );
  }
}
