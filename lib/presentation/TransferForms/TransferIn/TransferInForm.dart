
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TransferInList.dart';
class TransferInForm extends StatefulWidget {


  @override
  _TransferInFormState createState() => _TransferInFormState();
}

class _TransferInFormState extends State<TransferInForm> {

  String parlourID="";
  String shipmentID="";
  var quantity;
  DateTime dateTime=DateTime.now();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  List kitchenData;
  getKitchenData()async
  {
    var data =(await  _ref.collection("Inward").get()).docs.map((element) {
      return element.data();
    }).toList();
    setState(() {
      kitchenData=data;
    });
    // //print(kitchenData);
  }
  @override
  void initState() {
    super.initState();
    //getKitchenData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tranfer In List"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                            flex:2,
                            child: Text("Parlour ID",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                        Expanded(
                          flex:5,
                          child: Container(
                            child: TextFormField(
                              validator: (value)
                              {
                                if(value!=null&&value!="")
                                {
                                  return null;
                                }
                                return "Enter Parlour ID";
                              },
                              decoration: InputDecoration(
                                  enabled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  )
                              ),
                              onChanged: (value){
                                setState(() {
                                  parlourID=value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                            flex:2,
                            child: Text("Shipment ID",textAlign: TextAlign.left,)),
                        Expanded(
                          flex:5,
                          child: Container(
                            child: TextFormField(
                              validator: (value)
                              {
                                if(value!=null&&value!="")
                                {
                                  return null;
                                }
                                return "Enter Shipment ID";
                              },
                              decoration: InputDecoration(
                                  enabled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  )
                              ),
                              onChanged: (value){
                                setState(() {
                                  shipmentID=value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  FractionallySizedBox(
                    widthFactor: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: TextButton(
                        onPressed: () async{
                          if(_formKey.currentState.validate())
                          {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TransferInList()));
                          }

                        },
                        child: Text("Submit",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
