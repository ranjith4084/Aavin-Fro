import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/kichen_product.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/presentation/Info/info.dart';
import 'package:aavinposfro/presentation/Inventory/inventoryList.dart';

import 'package:aavinposfro/presentation/TransferForms/TransferIn/TransferInForm.dart';
import 'package:aavinposfro/presentation/TransferForms/TransferOut.dart';
import 'package:aavinposfro/presentation/TransferForms/productReturn.dart';
import 'package:aavinposfro/presentation/screens/InwardForms/InwardFormList.dart';
import 'package:aavinposfro/presentation/screens/InwardForms/InwardKItchenForm.dart';
import 'package:aavinposfro/presentation/screens/InwardForms/inwardForm.dart';
import 'package:aavinposfro/presentation/screens/Summary/dailySummary.dart';
import 'package:aavinposfro/presentation/screens/Summary/itemWiseSale.dart';
import 'package:aavinposfro/routes.dart';
import 'package:aavinposfro/sharedpreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../presentation/BillCancel/BillCancel.dart';
import '../presentation/TransferForms/DispatchList/DispatchForm.dart';
import '../presentation/screens/DayEndReport/DayEndReport.dart';
import '../presentation/screens/PreviousDispatchList/previousDispatchList.dart';
import '../presentation/screens/home/order_history_list.dart';
import '../presentation/screens/settlement/settlement.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  _ViewModel _vm;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          this._vm = vm;
          return Scaffold(
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 30, top: 30),
                child: Column(
                  children: [
                    ListTile(leading:Image.asset('assets/aavin_logo_xl.png',),

                      // leading: AssetImage('assets/aavin_logo_xl.png',)

                  // print(     SharedPrefService.pref.getString('storeId').toString(),);
                  // print(     SharedPrefService.pref.getString('storeName').toString(),);
                      title: Text(SharedPrefService.pref.getString('storeId').toString()=="null"?"Yet to Specify":SharedPrefService.pref.getString('storeId').toString(),
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 29)),
                      subtitle: Text(SharedPrefService.pref.getString('storeName').toString()=="null"?"Yet to Specify":SharedPrefService.pref.getString('storeName').toString()),
                    ),
                    // SizedBox(height: 15),
                    // InkWell(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>InventoryList()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Inventory List'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // InkWell(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>KichenProduct()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Kichen Product'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Info()));
                      },
                      child: ListTile(
                        title: Text('Info'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    // SizedBox(height: 5),
                    InkWell(
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistoryScreen()));

                        // _vm.navigation(AppRoutes.orderhistory);
                      },
                      child: ListTile(
                        title: Text('Bill Details'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    // SizedBox(height: 15),
                    // InkWell(
                    //   onTap: (){
                    //      Navigator.push(context, MaterialPageRoute(builder: (context)=>BillCancel()));
                    //
                    //
                    //   },
                    //   child: ListTile(
                    //     title: Text('Bill Cancel'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    // InkWell(
                    //   onTap: (){
                    //      Navigator.push(context, MaterialPageRoute(builder: (context)=>InwardForm()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Inward Entries'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),

                    // SizedBox(height: 20),
                    // InkWell(
                    //   onTap: (){
                    //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>InwardKitchenForm()));
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>InwardForm()));
                    //     //  sehfu8weagfuweatf7uwyegtf877wegfyth//
                    //   },
                    //   child: ListTile(
                    //     title: Text('Inward Kitchen Entries'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // InkWell(
                    //   onTap: (){
                    //     //print("++++++++++++++++++++++");
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>InwardList()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Inward Entries List'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    // InkWell(
                    //   onTap: (){
                    //     // //print("000000 The Username  - ${_vm.storedetails.storeCode} and parlour id - ${_vm.storedetails.parlourId} 0000000");
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>DispatchForm()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Dispatched List'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    // InkWell(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>previousDispatchList()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Previous Dispatch List'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 15),

                    // InkWell(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferInForm()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Transfer In List'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // InkWell(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductReturnForm()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Product Return'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // InkWell(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferOutForm()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Transfer Out'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Settlement()));
                      },
                      child: ListTile(
                        title: Text('Settlement'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    // SizedBox(height: 20),
                    // InkWell(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>DayEndReport()));
                    //   },
                    //   child: ListTile(
                    //     title: Text('Day End Report'),
                    //     trailing: Icon(Icons.keyboard_arrow_right),
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DailySummary()));
                      },
                      child: ListTile(
                        title: Text('Daily Summary'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    // SizedBox(height: 15),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemSummary()));
                      },
                      child: ListTile(
                        title: Text('Item wise Sale'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    // SizedBox(height: 15),
                    // ListTile(
                    //   title: Text('Signout'),
                    //   onTap: ()
                    //   {
                    //     showDialog(
                    //         context: context,
                    //         builder:(BuildContext context)=> AlertDialog(
                    //           content: Text("Do you want to signout ?"),
                    //           actions: [
                    //             TextButton(
                    //                 onPressed: (){
                    //                   _vm.updateStoreDetails("");
                    //                   _vm.signOut(null);
                    //                   Navigator.pushNamedAndRemoveUntil(context, "/login", ModalRoute.withName("/login"));
                    //                 },
                    //                 child: Text("Yes",style: TextStyle(fontSize: 18),)),
                    //             TextButton(
                    //                 onPressed: (){
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: Text("No",style: TextStyle(fontSize: 18)))
                    //           ],
                    //         ));
                    //   },
                    //   trailing: Icon(Icons.logout),
                    // ),
                    SizedBox(height: 420),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/kssmart.png"),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Developed by KS Smart",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                              15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
class _ViewModel {
  final Function(Null value) signOut;
  final bool isLoading;
  final Function (int phonenumber) updatePhonenumber;
  final Function(String storevalue) updateStoreDetails;
  final StoreDetails storedetails;
  final Function(String route)navigation;

  _ViewModel(
      this.signOut,
      this.updatePhonenumber,
      this.updateStoreDetails,
      this.isLoading,

      this.storedetails,
      this.navigation);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
            (value)=>store.dispatch(AuthSignOutAction()),
            (phoneNumber)=>store.dispatch(UpdatePhoneNumber(phoneNumber)),
            (storevalue)=>store.dispatch(StoreDetails(storevalue,storevalue, storevalue, storevalue, storevalue, storevalue, storevalue)),
        store.state.isLoading,
        store.state.storeDetails,
            (route)=>store.dispatch(NavigateAction(route))
    );
  }
}
