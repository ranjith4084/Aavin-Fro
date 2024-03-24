import 'package:aavinposfro/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class PointOfSaleOrder {
  String orderID;
  double cgst, sgst, igst, gst, total, sub_total;
  String paymentMethod;
  String refRegionID;
  String refZoneID;
  String storeID;
  String storeCode;
  DateTime Created_At;
  dynamic referenceId;
  String order_Status;
String product_type;
  // int paymentMethod;
  var productList;
  List<Product> products;

  PointOfSaleOrder(
      {this.orderID,
        this.product_type,
      this.cgst,
      this.sgst,
      this.igst,
      this.total,
      this.productList,
      this.paymentMethod,
      this.sub_total,
      this.storeID,
      this.storeCode,
      this.refRegionID,
      this.refZoneID,
      this.gst,
      this.referenceId,
      this.order_Status});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointOfSaleOrder &&
          product_type == other.product_type &&
          runtimeType == other.runtimeType &&
          orderID == other.orderID &&
          cgst == other.cgst &&
          sgst == other.sgst &&
          igst == other.igst &&
          gst == other.gst &&
          total == other.total &&
          sub_total == other.sub_total &&
          paymentMethod == other.paymentMethod &&
          refRegionID == other.refRegionID &&
          refZoneID == other.refZoneID &&
          storeID == other.storeID &&
          storeCode == other.storeCode &&
          Created_At == other.Created_At &&
          productList == other.productList &&
          products == other.products &&
          referenceId == other.referenceId&&
  order_Status==other.order_Status;

  @override
  int get hashCode =>
      orderID.hashCode ^
      product_type.hashCode^
      cgst.hashCode ^
      sgst.hashCode ^
      igst.hashCode ^
      gst.hashCode ^
      total.hashCode ^
      sub_total.hashCode ^
      paymentMethod.hashCode ^
      refRegionID.hashCode ^
      refZoneID.hashCode ^
      storeID.hashCode ^
      storeCode.hashCode ^
      Created_At.hashCode ^
      productList.hashCode ^
      products.hashCode ^
      order_Status.hashCode ^
      referenceId.hashCode;
  final formattedStr = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
  var exacttime = DateFormat.jm().format(DateTime.now());

  Map<String, Object> toUpdateMap() {
    // //print("dateeee $formattedStr");
    // //print("dateeee $referenceId");
    return {
      "Date": formattedStr,
      "Time": exacttime,
      "referenceId": referenceId,
      'Created_At': FieldValue.serverTimestamp(),
      'Products': this.productList,
      'Order_Total': this.total,
      'Order_SubTotal': this.sub_total,
      'Order_Gst': this.gst,
      'Order_ID': this.orderID,

      'Store_ID': this.storeID,
      'Store_Code': this.storeCode,
      'Ref_Region_Id': this.refRegionID,
      'Ref_Zone_Id': this.refZoneID,
      'Order_Cgst': this.cgst,
      'Order_Sgst': this.sgst,
      'Payment_Method': this.paymentMethod,
      'Order_Igst': this.igst,
      'Total_Item': this.total,
      "order_Status":"1",
      'product_type':this.product_type,
    };
  }

  PointOfSaleOrder.fromJson(Map<String, dynamic> json) {
    this.orderID = json['Order_ID'];
    this.product_type = json['product_type'];

    //this.deliveryDate=json['Delivery_Date'];
    this.storeID = json['Store_ID'];
    this.paymentMethod = json['Payment_Method'];
    this.storeCode = json['Store_Code'];
    this.refRegionID = json['Ref_Region_Id'];
    this.Created_At = json['Created_At'].toDate();
    this.refZoneID = json['Ref_Zone_Id'];
    this.total = json['Order_Total'];
    this.sgst = json['Order_Sgst'];
    this.sub_total = json['Order_SubTotal'];
    this.igst = json['Order_Igst'];
    this.cgst = json['Order_Cgst'];
    Map<Product, int> map = new Map<Product, int>();
    this.gst = json['Order_Gst'];
    if (json['Products'] != null) {
      this.products = new List<Product>();
      json['Products'].forEach((v) {
        Product product = Product.fromJson(v);
        products.add(product);
        int selectedquantity = product.selected_quantity;
        Product mapproduct = Product.fromJsonMap(v);
        map[mapproduct] = selectedquantity;
      });
      this.productList = map;
    }
  }
}
