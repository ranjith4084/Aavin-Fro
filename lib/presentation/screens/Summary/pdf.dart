import 'dart:io';

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:redux/redux.dart';

import '../../../actions/actions.dart';
import '../../../actions/auth_actions.dart';
import '../../../models/app_state.dart';

class User {
  var ProductCode;
  var ProductName;
  var NoOfItems;
  var ProductPrice;
  var cb;
  var ob;
  var ProductQuantity;

  User(
      {this.ProductCode,
      this.NoOfItems,
      this.ProductName,
      this.ProductPrice,
      this.cb,
      this.ob,
      this.ProductQuantity});
}

var exacttime = DateFormat.jm().format(DateTime.now());

class PdfApi {
  static Future<File> generateTable(filterdData, lastdate, todayinventory,
      yesterdayinventory, storecode, storeaddress) async {
    final pdf = Document();
    var total;
    print("please print today invetory ${todayinventory[0]["product"]}");
    print(
        "please print  yesterday inventory  ${yesterdayinventory[0]["product"]}");
    Map<String, dynamic> todaydate = todayinventory[0]["product"];
    // //print("please print  ${filterdData[0]["Products"][0]["Product_Price"]}");

    final headers = [
      'Product Code',
      'Product Name',
      'Ob Qty',
      "Sale Qty",
      "Product Quantity",
      'Sale Value',
      'CB Qty',
    ];
    int No_Of_Items = 0;
    double Product_Price = 0.0;
    List users = [];
    List productcode = [];

    // for(int i=0;i<=filterdData[0]["Products"].toString().length;i++){
    filterdData.forEach((element) {
      //print(
      //     "please prinsrgt  ${element["Products"][0]["Product_Code"]}++++${filterdData.length}");
      element["Products"].forEach((element) {
        if (productcode.contains(element["Product_Code"])) {
          //print("11");

          var index =
              users.indexWhere((e) => element["Product_Code"] == e.ProductCode);
          //print("11111+${users[index].NoOfItems}");
          //print("22222+${element["No_Of_Items"]}");

          users[index].NoOfItems += element["No_Of_Items"];
          users[index].ProductPrice +=
              element["Product_Price"] * element["No_Of_Items"];
          // var user = User(
          //     ProductCode: element["Product_Code"],
          //     ProductName: element["Product_Name"],
          //     NoOfItems: element["No_Of_Items"]+No_Of_Items,
          //     ProductQuantity: element["Product_Quantity"],
          //     ProductPrice: element["Product_Price"]+price
          // );
          // // users.add(user);

          // productcode.add(element["Product_Code"]);
        } else {
          //print("22");

          var user = User(
              ProductCode: element["Product_Code"],
              ProductName: element["Product_Name"],
              cb: todayinventory[0]["product"][element["Product_Code"]],
              NoOfItems: element["No_Of_Items"],
              ProductQuantity: element["Product_Quantity"],
              ProductPrice: element["Product_Price"],
              ob: yesterdayinventory[0]["product"][element["Product_Code"]]);
          No_Of_Items = element["No_Of_Items"];
          Product_Price = element["Product_Price"];
          users.add(user);
          productcode.add(element["Product_Code"]);
        }
      });

      // }
    });

    // final users = [
    //   filterdData[0]["Products"].forEach((element) {
    //     User(
    //         ProductCode: filterdData[0]["Products"][0]["Product_Code"],
    //         // ProductName: element["Product_Name"],
    //         // NoOfItems: element["No_Of_Items"],
    //         // ProductQuantity: element["Product_Quantity"],
    //         // ProductPrice: element["Product_Price"]
    //     );
    //   })
    // ];

    //print(users);
    final data = users
        .map((user) => [
              user.ProductCode,
              user.ProductName,
              user.cb,
              user.NoOfItems,
              user.ProductQuantity,
              user.ProductPrice.toStringAsFixed(2),
              user.ob,
            ])
        .toList();

    final image = await imageFromAssetBundle('assets/aavin_logo_xl.png');
    pdf.addPage(
      Page(
        build: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset('assets/aavin_logo_xl.png',),
              Image(image, height: 100, width: 150),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                    "THE TAMILNADU CO-OPERATIVE MILK PRODUCERS FEDERATION "),
              ),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.center,
                child: Text("LIMITED CLOSING STOCK SUMMARY"),
              ),
              SizedBox(height: 5.0),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(height: 5.0),
              Text("Report Date $lastdate"),
              SizedBox(height: 10.0),
              Text("Report Time $exacttime"),

              SizedBox(height: 5.0),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(height: 5.0),
              Text("Store Code : ${storecode}"),
              SizedBox(height: 10.0),
              Text("Store Address : ${storeaddress}"),
              SizedBox(height: 12.0),
              // Text("Store Code : ${filterdData[0]["Products"]}"),
              // Table.fromTextArray(
              //   headers: headers,
              //   data: data,
              // ),
            ],
          );
        },
      ),
    );
    pdf.addPage(Page(
      build: (context) => Table.fromTextArray(
        headers: headers,
        data: data,
      ),
    ));

    return saveDocument(name: "${lastdate},${exacttime}.pdf", pdf: pdf);
  }

  static Future<File> saveDocument({
    String name,
    Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
