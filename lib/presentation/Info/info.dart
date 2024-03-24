import 'package:aavinposfro/Settings/Profile.dart';
import 'package:aavinposfro/sharedpreference.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  @override
  State<Info> createState() => _InfoState();
}

final storeController = TextEditingController();
final placeController = TextEditingController();


class _InfoState extends State<Info> {
  GlobalKey<FormState> globallkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: globallkey,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Info Screen"),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Shop ID : ",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: storeController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: SharedPrefService.pref.getString('storeId').toString()!="null"?SharedPrefService.pref.getString('storeId').toString():"Shop ID"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Shop Name : ",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: placeController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:SharedPrefService.pref.getString('storeName').toString()!="null"?SharedPrefService.pref.getString('storeName').toString(): "Shop Name"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: InkWell(
                  onTap: () {
                    print("${storeController.text} ${placeController.text}");
                    if (globallkey.currentState.validate()) {
                      SharedPreferencesUtil.storeId(storeController.text);
                      SharedPreferencesUtil.storeName(placeController.text);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Profile()));
                      SnackBar(
                          elevation: 8.0,
                          backgroundColor: Colors.blue,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Done",
                            style: Theme.of(context).textTheme.subtitle1,
                          ));

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 8.0,
                          backgroundColor: Colors.blue,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Please Fill All The Details : ",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

