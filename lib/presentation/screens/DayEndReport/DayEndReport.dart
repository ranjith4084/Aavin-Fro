import 'package:aavinposfro/presentation/screens/Summary/pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../actions/actions.dart';
import '../../../actions/auth_actions.dart';
import '../../../middleware/app_middleware.dart';
import '../../../models/app_state.dart';


class DayEndReport extends StatefulWidget {
  @override
  State<DayEndReport> createState() => _DayEndReportState();
}

class _DayEndReportState extends State<DayEndReport> {
  void initState() {
    // initSetup();
  }
  bool _switchValue = true;
  initSetup() async {
    await fetchDataFromFirebase();
    await fetchtodayinvetory();
  }
  _ViewModel _vm;
  DateTime currentdate = DateTime.now();
  DateTime cur = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentdate,
        firstDate: DateTime(2015),
        lastDate: cur);
    if (pickedDate != null && pickedDate != currentdate)
      setState(() {
        String date = formatter.format(pickedDate);
        // ////print(date);
        currentdate = pickedDate;
      });
  }
  List<DocumentSnapshot> filterData = [];
  List<DocumentSnapshot> todayinventory = [];
  List<DocumentSnapshot> yesterdayinventory = [];

    Future fetchtodayinvetory() async {
      // //print(formatter.format(currentdate));
      QuerySnapshot posOrderData =
      await FirebaseFirestore.instance
          .collection("TodaysInventoryChanges")
          .where("Store_Code", isEqualTo: storeCode)
          .where("Date", isEqualTo: formatter.format(currentdate))
          .get();
      // //print("11S${posOrderData.docs.length}");

      todayinventory = posOrderData.docs;


    }
  Future fetchyesterdayinvetory() async {
    // //print(currentdate.subtract(Duration(days:1)));
    QuerySnapshot posOrderData =
    await FirebaseFirestore.instance
        .collection("TodaysInventoryChanges")
        .where("Store_Code", isEqualTo: storeCode)
        .where("Date", isEqualTo: formatter.format(currentdate.subtract(Duration(days:1))))
        .get();
    // //print("11S${posOrderData.docs.length}");

    yesterdayinventory = posOrderData.docs;


  }
    // final formattedStr = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);

  Future fetchDataFromFirebase() async {
    // //print(formatter.format(currentdate));
    QuerySnapshot posOrderData =

        // await FirebaseFirestore.instance.collection("POS_Order").where("Date", isEqualTo: formattedStr).get();
        await FirebaseFirestore.instance
            .collection("POS_Order")
            .where("Store_Code", isEqualTo: storeCode)
            .where("Date", isEqualTo: formatter.format(currentdate))
            .get();
    // //print(posOrderData.docs.length);
    filterData = posOrderData.docs;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
      this._vm = vm;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Day End Report"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Date :",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(color: Colors.black),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text("${formatter.format(currentdate)}"),
                              ),
                              Icon(
                                Icons.calendar_today_sharp,
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: Text(
                        'Generate PDF',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blue)),
                      onPressed: () async {
                        await fetchDataFromFirebase();
                        await fetchtodayinvetory();
                        await fetchyesterdayinvetory();
                        var lastdate = formatter.format(currentdate);
                        // print("filter date = ${filterData}");
                        //  print("please date  ${filterData[0]["Products"][0]["Product_Price"]}");
                        //
                        //   print("today inventory = ${todayinventory}");
                        // print("yesterday inventory = ${yesterdayinventory}");




// //print("Store Code ${_vm.storedetails.storeCode}");
var storecode = _vm.storedetails.storeCode;
                        var storeaddress=        _vm.storedetails.storeAddress;

                        final pdfFile =
                            await PdfApi.generateTable(filterData, lastdate,todayinventory,yesterdayinventory,storecode,storeaddress);
                        PdfApi.openFile(pdfFile);

                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );});}
  }

class _ViewModel {
  final Function(Null value) signOut;
  final bool isLoading;
  final Function(int phonenumber) updatePhonenumber;
  final Function(String storevalue) updateStoreDetails;
  final StoreDetails storedetails;
  final Function(String route) navigation;

  _ViewModel(this.signOut, this.updatePhonenumber, this.updateStoreDetails,
      this.isLoading, this.storedetails, this.navigation);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
            (value) => store.dispatch(AuthSignOutAction()),
            (phoneNumber) => store.dispatch(UpdatePhoneNumber(phoneNumber)),
            (storevalue) => store.dispatch(StoreDetails(storevalue, storevalue,
            storevalue, storevalue, storevalue, storevalue, storevalue)),
        store.state.isLoading,
        store.state.storeDetails,
            (route) => store.dispatch(NavigateAction(route)));
  }
}