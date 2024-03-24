import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ProductReturnForm extends StatefulWidget {


  @override
  _ProductReturnFormState createState() => _ProductReturnFormState();
}

class _ProductReturnFormState extends State<ProductReturnForm> {
  String productID="";
  String productName="Not Found";
  DateTime dateTime=DateTime.now();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  var quantity;
  List kitchenData;
  String billNo;
  String valueGlobal;

  getKitchenData()async
  {
    var data =(await  _ref.collection("KitchenInward").get()).docs.map((element) {
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
    getKitchenData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product Return"),
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
                            child: Text("Bill No",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                        Expanded(
                          flex:5,
                          child: TextFormField(
                              validator: (value)
                              {
                                if(value!=null&&value!="")
                                {
                                  return null;
                                }
                                return "Enter Bill No";
                              },
                            decoration: InputDecoration(
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                )
                            ),
                            onChanged: (value){
                              setState(() {
                               billNo=value;
                                });
                              },
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
                            child: Text("Product ID",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                        Expanded(
                          flex:5,
                          child: TextFormField(
                              validator: (value)
                              {
                                if(value!=null&&value!="")
                                {
                                  return null;
                                }
                                return "Enter Product ID";
                              },
                            decoration: InputDecoration(
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                )
                            ),
                            onChanged: (value){
                              setState(() {
                                setState(() {
                                  kitchenData.forEach((element) {
                                    if(element["product_id"]==value)
                                    {
                                      setState(() {
                                        productName=element["product_name"];
                                        productID=value;
                                      });
                                      // //print(element["product_name"]);
                                    }
                                    else{
                                      // //print(element["product_id"]);

                                    }

                                  });
                                });
                              });
                            },
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
                            child: Text("Product Name",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                        Expanded(
                          flex:5,
                          child: Container(

                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(productName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
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
                            child: Text("Product Quantity",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                        Expanded(
                          flex:5,
                          child: TextFormField(
                              validator: (value)
                              {
                                if(value!=null&&value!="")
                                {
                                  return null;
                                }
                                return "Enter Quantity";
                              },
                            decoration: InputDecoration(
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                )
                            ),
                            onChanged: (value){
                              setState(() {
                                quantity=value;
                              });
                            },
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
                            child: Text("Date",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                        Expanded(
                          flex:5,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CalendarDatePicker(
                                onDateChanged: (DateTime value) {
                                  setState(() {
                                    dateTime=value;
                                  });
                                },
                                lastDate: DateTime(2100),
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),),
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
                            child: Text("Value",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                        Expanded(
                          flex:5,
                          child: TextFormField(
                              validator: (value)
                              {
                                if(value!=null&&value!="")
                                {
                                  return null;
                                }
                                return "Enter Value";
                              },
                            decoration: InputDecoration(
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                )
                            ),
                            onChanged: (value){
                              setState(() {
                                valueGlobal=value;
                              });
                            },
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
                        onPressed: ()async {
                          if(_formKey.currentState.validate())
                          {
                            await _ref.collection("InwardEntries").add({
                              "Product_ID":productID,
                              "Product_name":productName,
                              "Quantity":quantity,
                              "Date":dateTime
                            });
                            Navigator.of(context).pop();
                          }
                          else{
                            return;
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
