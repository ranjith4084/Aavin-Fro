
import 'dart:async';
import 'dart:convert';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:aavinposfro/routes.dart';
import 'package:aavinposfro/sharedpreference.dart';
import 'package:aavinposfro/utils/StringUtils.dart';
import 'package:aavinposfro/utils/colors_utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../middleware/app_middleware.dart';
import 'indent/product_card.dart';

List Kichprod;
List todaysaleprod = [];
List todaysaleprod1 = [];
List todaysalevalue = [];
List todaysalevalue1 = [];
List todaysalepayment = [];
var todayprodoverall;
Map mapproduct1;
// Map mapproduct2={};
Map mapproduct3;
// Map mapproduct4={};
Map mapro4;
double cost;
Map mapro2;
double _cgst=0.0;
double _sgst=0.0;
double _total=0.0;
double _basicPrice=0.0;
double _localvalue=0.0;
double _item=0.0;
double _resipocal=0.0;
var todayprodoverall1;
double card = 0;
double cash = 0;
double upi = 0;
double third = 0;
var todayprodoverallobject;

class HomePage extends StatefulWidget {
  final List<Product> products;
  final Stock stock;
  final Cart cart;

  HomePage({this.products, this.cart, this.stock});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _ViewModel _vm;
  final TextEditingController _searchTextEditingController =
  new TextEditingController();
  static const platform = const MethodChannel('samples.flutter.dev/print');
  int paymentMethod = 1;
  var selectedPay = "Cash Payment";
  Map invertory = {};
  Map subid = {};

  @override
  void initState() {
    super.initState();
    initSetup();
    init();
    productlist();
  }

  List kichenids = [
    "N39",
    "N41",
    "H01",
    "H02",
    "H04",
    "H05",
    "H06",
    'P01',
    'P08',
    'P02',
    'P03'
  ];

  List invertoryList = [];

  productlist() async {
    await kichenids.forEach((element) async {
      // //print(element);
      DocumentSnapshot snapshot = (await FirebaseFirestore.instance
          .collection("KitchenProduct")
          .doc(element)
          .get());

      invertoryList.add(snapshot.data());

      // //print("Product added into the list");

      // //print("+${invertoryList.length}");
    });

    return invertoryList;
  }

  initSetup() async {
    await fetchPosDataFromFirebaseFirestore();
    DocumentSnapshot snapshot = (await FirebaseFirestore.instance
        .collection("InventoryChanges")
        .doc("P167")
        .get());
    invertory = snapshot.data();
    // //print("666666$invertory");
  }

  void init() {
    _searchTextEditingController.addListener(() {
      String _searchInput = _searchTextEditingController.text;
      if (_vm != null) {
        _vm.updateSearch(_searchInput);
      }
    });
  }

  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          this._vm = vm;
          return Scaffold(
            backgroundColor: Color(0xFF1D8DCF),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [

                        // Expanded(
                        //   flex: 2,
                        //   child: Transform.scale(
                        //     scale: 1.1,
                        //     child: CupertinoSwitch(
                        //       value: _switchValue,
                        //       onChanged: (value) async {
                        //         setState(() {
                        //           if (_switchValue == false) {
                        //             // //print("yes inside loop");
                        //           } else {
                        //             // //print("no outside loop");
                        //             // endOfDay(finSubstringpost);
                        //             // demo();
                        //
                        //           }
                        //
                        //           _switchValue = value;
                        //           // //print(_switchValue);
                        //
                        //         });
                        //
                        //         if(_switchValue==false){
                        //           FirebaseFirestore ref = FirebaseFirestore.instance;
                        //           await ref
                        //               .collection("TodaysInventoryChanges")
                        //           // .where("Store_Code", isEqualTo: storeCode)
                        //               .add({"product": invertory, "Date": formattedStr,"Store_Code":storeCode});
                        //         }else{
                        //
                        //         }
                        //       },
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 14,
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 175,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                Image.asset(
                                  'assets/aavin_logo_xl.png',
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(

                              onTap: () {
                                _vm.navigation(AppRoutes.profile);
                              },

                              child: Align(
                                child: Container(

                                  height: 80,
                                  width: 80,
                                  padding: EdgeInsets.all(13),
                                  margin: EdgeInsets.only(top: 20),
                                  child: Icon(Icons.menu,
                                      size: 40, color: Colors.white),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),

                  SharedPrefService.pref.getString('storeId').toString()=="null"?Container(height: 670,  width: MediaQuery.of(context).size.width,color: Colors.white,child: Center(child:
                  Text(
                    "Please Mension the Store ID and Store Code in INFO",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  ),):Expanded(

                    child: DefaultTabController(
                      initialIndex: 0,
                      length: 1,
                      child: Scaffold(
                        appBar: AppBar(
                          title: Container(
                            margin: EdgeInsets.only(
                                top: 20, right: 20, left: 20, bottom: 30),
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _searchTextEditingController,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    bottom: 10,
                                    left: 10, // HERE THE IMPORTANT PART
                                  ),
                                  suffixIcon: Icon(
                                    Icons.search,
                                    size: 35,
                                    color: Color(0xFF1D8DCF),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide:
                                      BorderSide(color: Colors.white))),
                            ),
                          ),
                          backgroundColor: Color(0xFF1D8DCF),
                          elevation: 0,
                          bottom: TabBar(

                            tabs: <Widget>[
                              Tab(
                                child: Text(
                                  "Daily Products",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                            ],
                          ),
                        ),
                        body: TabBarView(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Container(
                                child: Padding(
                                    padding: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: productView()),
                                      ],
                                    )),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )),
                              ),
                            ),
                            // KichenProduct(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget productList(List<Product> productList) {
    // //print("+++++++++++++++--length-------${productList.length.toString()}" +
    //     " len");
    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          primary: false,
          //  key: new PageStorageKey("products"),
          cacheExtent: 300,
          itemBuilder: (context, index) {
            var product = productList[index];
            return ProductCard(
              product,
              cartQuantity: _vm.cart.items.containsKey(product)
                  ? _vm.cart.items[product]
                  : 0,
              stockQuantity: _vm.stock.items.containsKey(product)
                  ? _vm.stock.items[product]
                  : 0,
            );
          },
          padding: EdgeInsets.only(bottom: 64),
          itemCount: productList.length),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text('Total Amount',
                      style: TextStyle(fontSize: 20, color: Colors.black))),
              Expanded(
                  flex: 2,
                  child: Text(
                      "₹" +
                          //totalAmount

                          _vm.cart.total.total_price.toStringAsFixed(2),
                      style: TextStyle(fontSize: 20, color: Colors.black))),
              Expanded(
                flex: 1,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Color(0xFF1D8DCF)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)))),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                              title: Container(
                                  alignment: Alignment.center,
                                  child: Text(StringUtils.payment_method)),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DropdownButtonFormField(
                                    items: [
                                      "Cash Payment",
                                      "Card Payment",
                                      "UPI Payment",
                                      "ThirdParty Payment"
                                    ].map((e) {
                                      return DropdownMenuItem(
                                          value: e, child: Text(e));
                                    }).toList(),
                                    value: selectedPay,
                                    onChanged: (value) {
                                      var map = {
                                        "Cash Payment": 1,
                                        "Card Payment": 2,
                                        "UPI Payment": 3,
                                        "ThirdParty Payment": 4
                                      };
                                      setState(() {
                                        selectedPay = value;
                                        // //print(selectedPay);
                                        paymentMethod = map[value];
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: TextButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              ColorUtils.lightBlue),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                  side:
                                                  BorderSide(color: ColorUtils.lightBlue)))),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // cardPayment();
                                        onClick();
                                        // //print(
                                        //     "List of today sale product ${todaysaleprod} and the value ${todaysalevalue}");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 5,
                                            right: 5),
                                        child: Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child: Text(
                                            "Pay now",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> temp = {};
  Map tempInventory;

  updateInventoryFunc(List<Map<dynamic, dynamic>> map) async {
    // //print("inside....");
    tempInventory = _vm.inventory;
    Future.forEach(map, (element) {
      temp[element["Product_Code"]] =
          FieldValue.increment(int.parse(element["No_Of_Items"].toString()));
      tempInventory.update(
          element["Product_Code"],
              (value) =>
          // (value ?? 0) - int.parse(element["No_Of_Items"].toString()));
          (value ?? 0) -0);
    });

    setState(() {
      _vm.updateInventory(tempInventory);
    });

    // //print("test123${tempInventory}");
    FirebaseFirestore ref = FirebaseFirestore.instance;
    await ref
        .collection("InventoryChanges")
        .doc(_vm.storedetails.storeCode)
        .update(tempInventory);
  }

  Widget productView() {
    if (_vm.searchProducts != null) {
      if (_vm.searchProducts.length > 0) {
        return productList(_vm.searchProducts);
      } else {
        return Center(child: Text("No items found."));
      }

    } else {
      if (_vm.products != null && _vm.products.length > 0) {
        return productList(_vm.products);
      } else {
        return Center(child: Text("No items found."));
      }
    }
  }

  AudioPlayer audioPlayer;
  AudioCache cache = new AudioCache();
  String barCode = "";

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        "#ff6666", "Done", true, ScanMode.BARCODE)
        .listen((barcode) {
      this.barCode = barcode;
      if (barcode != null && barcode.length > 1) {
        play(barcode);
      }
    });
  }



  dynamic referenceId;

  onClick() async {
    try {
      // //print("inside");
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      // //print("date $timestamp");
      List<Product> productlist = List();
      _vm.order.cart.items
        ..forEach((key, value) {
          key.selected_quantity = value;
          if (key.selected_quantity > 0) {
            productlist.add(key);
          }
        });
      List<Map<dynamic, dynamic>> map = (productlist.map((e) {
        e.product_basicprice =
            num.parse(e.product_basicprice.toStringAsFixed(2));

        return e.toMap();
      }).toList());

      List productcode = [];
      List quantityitem = [];
      for (int i = 0; i < map.length; i++) {
        productcode.add(map[i]["Product_Code"]);
      }
      for (int i = 0; i < map.length; i++) {
        quantityitem.add(map[i]["No_Of_Items"]);
      }


      String listarr3 = "";
      String listarr4 = "";

      for (int i = 0; i < productcode.length; i++) {
        listarr3 = "${productcode[i]}" + ":" + "${quantityitem[i]}";
        listarr4 = listarr4 + listarr3 + ",";
      }
      //const string = 'dartlang';
      int strlen = listarr4.length - 1;
      String finSubstringpost = listarr4.substring(0, strlen);

      cost = num.parse(_vm.cart.total.total_price.toStringAsFixed(2));




      print("++++++++++++++++++++++++++++$map++++++");
      // await printBill(map, timestamp, paymentMethod);
      PointOfSaleOrder pointOfSaleOrder = PointOfSaleOrder(
        cgst: num.parse(_vm.cart.total.total_cgst.toStringAsFixed(2)),
        gst: num.parse(_vm.cart.total.total_gst.toStringAsFixed(2)),
        igst: num.parse(_vm.cart.total.total_igst.toStringAsFixed(2)),
        orderID: timestamp.toString(),
        paymentMethod: selectedPay,
        productList: map,
        refRegionID: _vm.storedetails.regionID,
        refZoneID: _vm.storedetails.zoneID,
        sgst: num.parse(_vm.cart.total.total_sgst.toStringAsFixed(2)),
        storeCode: SharedPrefService.pref.getString('storeId').toString(),
        storeID: _vm.storedetails.storeDocumentID,
        sub_total:
        num.parse(_vm.cart.total.total_basicprice.toStringAsFixed(2)),
        total: num.parse(_vm.cart.total.total_price.toStringAsFixed(2)),
        referenceId: referenceId,
        product_type: "Daily Product",
      );
      _vm.updatePos(pointOfSaleOrder);
      print("12345678901 ${_vm.cart.total.total_cgst.toStringAsFixed(2)}");
      await updateInventoryFunc(map);
      print("Print started");

      // double _reprintcal=map[0]["No_Of_Items"]*map[0]["Product_BasicPrice"];
      // total map[0]["Product_Cgst"]+reprintcal+map[0]["Product_Sgst"]).toStringAsFixed(2),
      // print("value ${map[0]["Product_Cgst"]}   ==  ${map[0]["Product_Sgst"]} === ${reprintcal} === ${map[0]["Product_Cgst"]+reprintcal+map[0]["Product_Sgst"]}");
      await map.forEach((element) async {
        // print("${double.parse(element["Product_BasicPrice"].toStringAsFixed(2))}");
        _sgst=((double.parse(element["Product_Sgst"].toStringAsFixed(2))*element["No_Of_Items"]))+_sgst;
        _cgst=((double.parse(element["Product_Cgst"].toStringAsFixed(2))*element["No_Of_Items"]))+_cgst;
        // _item=element["No_Of_Items"]+_item;
        print("heererre basepric3 ${element["Product_BasicPrice"]}   item ${element["No_Of_Items"]}  it $_item   $_basicPrice");
        _basicPrice=(element["Product_BasicPrice"]*element["No_Of_Items"])+_basicPrice;
        // double _reprintcal=element["No_Of_Items"]*element["Product_BasicPrice"];
        // _total=(element["Product_Cgst"]+_reprintcal+element["Product_Sgst"]+_total).toStringAsFixed(2);
        print(map);
        print("Here the original value Cgst ${element["Product_Cgst"]} sgst ${element["Product_Sgst"]} item ${element["No_Of_Items"]}  baseprice ${element["Product_BasicPrice"]} ");

      });
       _localvalue = _item*_basicPrice;

      await printBill(map, timestamp, paymentMethod);
      print("Print ended");
      SharedPreferences prefs = await SharedPreferences.getInstance();

      /// List adding in todaysaleprod

      ///
      showDialog(
          context: context,
          builder: (BuildContext) {
            return AlertDialog(
              title: Text("Do you want reprint ?"),
              actions: [
                TextButton(
                    onPressed: () {
                      //print("Map ${map}");
                      printBill1(map, timestamp, paymentMethod);
                    },
                    child: Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                       _cgst=0.0;
                       _sgst=0.0;
                       _total=0.0;
                       _basicPrice=0.0;
                       _item=0.0;
                       _resipocal=0.0;
                       _localvalue=0.0;
                    },
                    child: Text("No"))
              ],
            );
          });
      print("12345678902 ${_vm.cart.total.total_cgst.toStringAsFixed(2)}");
      _vm.resetOrder();

    } catch (ex) {
      //print("Catch");
      //print(ex.toString());
    }
// if (isSuccess) {
//
// } else {
//   // debugPrint("not printed");
// }
  }



  final List productqty = [];
  final List productqty2 = [];
  List result = [];
  List result2 = [];


  DateTime dt = DateTime.parse('2022-04-06 00:00:00+05:30');
  DateTime dt2 = DateTime.parse('2022-04-06 23:59:59+05:30');

  double cash = 0.0;
  double Card = 0.0;
  double UPI = 0.0;
  double third = 0.0;

  fetchPosDataFromFirebaseFirestore() async {
    QuerySnapshot posOrderData = await FirebaseFirestore.instance
        .collection("POS_Order")
        .where("Created_At", isGreaterThan: dt)
        .where("Created_At", isLessThan: dt2)
        .get();

    List<DocumentSnapshot> docs = posOrderData.docs;

    //1st logic
    int totalproduct = 0;
    String jsonTags;
    int totalproduct1 = 0;
    int totalproductqty = 0;
    int totalproductqty1 = 0;

    final List productqty1 = [];
    docs.forEach((element) {
      List Products = element["Products"];

      if (Products.isNotEmpty) {
        Products.forEach((element2) {
          totalproduct += element2["No_Of_Items"];

          String ProductName = element2["Product_Code"];

          productqty.add(element2["Product_Code"]);
          productqty2.add(element2["No_Of_Items"]);
        });
      }

      result = productqty.toSet().toList();

      result2 = productqty2.toSet().toList();

      if (result.isNotEmpty) {
        for (var i = 0; i < result.length; i++) {
          ///
          if (result.isNotEmpty) {
            result.forEach((element2) {
              if (element2 == Products) {}
            });
          }

          jsonTags = jsonEncode(result);
        }
      }

      if (element["Payment_Method"] == 1) {
        cash += element["Order_Total"];
      } else if (element["Payment_Method"] == 2) {
        Card += element["Order_Total"];
      } else if (element["Payment_Method"] == 3) {
        UPI += element["Order_Total"];
      } else {
        third += element["Order_Total"];
      }
    });
  }

  final formattedStr = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);


  List filterdData = [];
  List data = [];
  bool isLoading = false;

  printBill(map, timestamp, paymentMethod) async {
    print(map);
    print("Here the value Cgst ${_cgst.toStringAsFixed(2)} sgst ${_sgst.toStringAsFixed(2)}   Subtotal ${_basicPrice.toStringAsFixed(2)} total ${(_sgst+_basicPrice+_cgst).toStringAsFixed(2)}");

    print("12345678901 ${_vm.cart.total.total_cgst.toStringAsFixed(2)}");
    print("1234567890 ${_vm.cart.total.total_cgst.toStringAsFixed(2)}");
    bool isSuccess = await platform.invokeMethod('print', <String, dynamic>{
      'data': json.encode(jsonEncode(map)),
      'orderID': timestamp.toString(),
      'cgst': _cgst.toStringAsFixed(2),
      'igst': _vm.cart.total.total_igst.toStringAsFixed(2),
      'sgst': _sgst.toStringAsFixed(2),
      'subtotal': _basicPrice.toStringAsFixed(2),
      'total': (_sgst+_basicPrice+_cgst).toStringAsFixed(2),
      'address':SharedPrefService.pref.getString('storeName').toString(),
      'paymentmethod': paymentMethod.toString(),
      'storecode':SharedPrefService.pref.getString('storeId').toString(),
    });
  }

  printBill1(map, timestamp, paymentMethod) async {
    print("ewaessrcxgsdf");
    print(map);
    double reprintcal=map[0]["No_Of_Items"]*map[0]["Product_BasicPrice"];
    print("value ${map[0]["Product_Cgst"]}   ==  ${map[0]["Product_Sgst"]} === ${reprintcal} === ${map[0]["Product_Cgst"]+reprintcal+map[0]["Product_Sgst"]}");
    print("1234567890 ${_vm.cart.total.total_cgst.toStringAsFixed(2)}");
    bool isSuccess = await platform.invokeMethod('print', <String, dynamic>{
      'data': json.encode(jsonEncode(map)),
      'orderID': timestamp.toString(),
      'cgst': _cgst.toStringAsFixed(2),
      'igst': _vm.cart.total.total_igst.toStringAsFixed(2),
      'sgst': _sgst.toStringAsFixed(2),
      'subtotal': _basicPrice.toStringAsFixed(2),
      'total': (_sgst+_basicPrice+_cgst).toStringAsFixed(2),
      'address':SharedPrefService.pref.getString('storeName').toString(),
      'paymentmethod': paymentMethod.toString(),
      'storecode': SharedPrefService.pref.getString('storeId').toString(),
    });
  }

  bool isUpdate = false;

  void play(String barcode) async {
    if (barcode == "1") {
    } else if (barcode == "-1") {
    } else {
      if (isUpdate == false) {
        Completer<int> completer = Completer();

        _vm.updateCart(barcode, 1, completer);
        setUpdate(true);
        Timer(Duration(seconds: 1), () {
          setUpdate(false);
        });
        completer.future.then((value) async {
          if (value == 1) {
            await cache.play('beep.mp3');
          } else {
            setUpdate(false);

            // isUpdate = false;
          }
        });
      }
    }
  }

  void setUpdate(bool isUpdate) async {
    setState(() {
      this.isUpdate = isUpdate;
    });
  }
}

class _ViewModel {
  double num;
  final Map inventory;
  final Function(Map inventory) updateInventory;
  final bool isLoading;
  final User user;
  final Order order;
  final Stock stock;
  final List<Product> products, searchProducts;
  final Cart cart;
  final int phoneNumber;
  final Function() checkout;
  final Function(String route) navigation;
  final Function() initStockEdit;
  final Function() signOut;
  final Function() orderhistory;
  final Function(PointOfSaleOrder pos) updatePos;
  final Function() resetOrder;
  final Function(String text) updateSearch;
  final StoreDetails storedetails;
  final Function(double currentUserNum) updateNum;
  final Function(String product, int quantity, Completer<int> completer)
  updateCart;

  _ViewModel(
      this.num,
      this.updateNum,
      this.inventory,
      this.updateInventory,
      this.isLoading,
      this.user,
      this.order,
      this.stock,
      this.products,
      this.cart,
      this.checkout,
      this.initStockEdit,
      this.signOut,
      this.phoneNumber,
      this.orderhistory,
      this.resetOrder,
      this.storedetails,
      this.updateCart,
      this.updatePos,
      this.navigation,
      this.searchProducts,
      this.updateSearch,
      );

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        store.state.num,
            (currentUserNum) => store.dispatch(UpdateNum(num: currentUserNum)),
        store.state.inventoryQuantity,
            (inventory) => store
            .dispatch(UpdateInventoryQuantity(inventoryQuantity: inventory)),
        store.state.isLoading,
        store.state.currentUser,
        store.state.order,
        store.state.stock,
        store.state.products,
        store.state.cart,
            () => store.dispatch(NavigateAction(AppRoutes.checkout)),
            () => store.dispatch(InitStockEditAction()),
            () => store.dispatch(AuthSignOutAction()),
        store.state.phoneNumber,
            () => store.dispatch(NavigateAction(AppRoutes.orderhistory)),
            () => store.dispatch(ResetOrder("Success")),
        store.state.storeDetails,
            (product, quantity, completer) =>
            store.dispatch(UpdateCartAction(product, quantity, completer)),
            (posorderModel) => store.dispatch(UpdatePosSale(posorderModel)),
            (route) => store.dispatch(NavigateAction(route)),
        store.state.searchProducts,
            (text) => store.dispatch(SearchProduct(text)));
  }
}

double totalAmount = 0.0;
