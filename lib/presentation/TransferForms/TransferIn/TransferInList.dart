import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class TransferInList extends StatefulWidget {
  @override
  _TransferInListState createState() => _TransferInListState();
}

class _TransferInListState extends State<TransferInList> {
  List kitchenData=[];
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
        TextButton(onPressed: (){
          Navigator.of(context).pop();

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add_outlined),
        onPressed: () {
          _showDialog();
        },

      ),
      appBar: AppBar(
        title: Text("Dispatched Product List"),
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
