import 'package:aavinposfro/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class IndentOrder {
  String displayOrderID;
  int deliveryDate;
  String docID;
  DateTime Created_At;
  DateTime Updated_At;

  String refRegionID;
  String refZoneID;
  int phoneNumber;
  String storeAddress;
  String contactPerson;
  Map<Product, int> items;


  IndentOrder(this.displayOrderID,
      this.deliveryDate,
      this.products,
      this.status,
      this.storeID,
      this.storeCode,
      this.order_total,
      this.order_subtotal,
      this.order_gst,
      this.order_cgst,
      this.order_sgst,
      this.order_igst,
      this.totalItem,
      this.refRegionID,
      this.refZoneID,
      this.storeAddress,
      this.phoneNumber,
      this.contactPerson,
      this.items);

 List<Product>products;
  int status;
  String storeID;
  String storeCode;
  double order_total;
  double order_subtotal;
  double order_gst;
  double order_cgst;
  double order_sgst;
  double order_igst;
  int totalItem;


  Map<String, Object> toMap() {
    return {
      'Delivery_Date': this.deliveryDate,
      'Display_Order_ID': this.displayOrderID,
      'Created_At': FieldValue.serverTimestamp(),
      'Updated_At': FieldValue.serverTimestamp(),
      'Products': this.products.where((i) => i.selected_quantity>0).map((item) {
        return item.toMap();
      }).toList(),
      'Status': status,

      'Order_Total': this.order_total,
      'Order_SubTotal': this.order_subtotal,
      'Order_Gst': this.order_gst,
      'Order_Cgst': this.order_cgst,
      'Order_Sgst': this.order_sgst,
      'Order_Igst': this.order_igst,
      'Total_Item': this.totalItem,
      'Store_ID': this.storeID,
      'Store_Code': this.storeCode,
      'Ref_Region_Id': this.refRegionID,
      'Ref_Zone_Id': this.refZoneID,
      'Phone_Number': this.phoneNumber,
      'Store_Address': this.storeAddress,
      'Contact_Person': this.contactPerson
    };
  }

  IndentOrder.fromJson(Map<String, dynamic> json) {
    this.displayOrderID=json['Display_Order_ID'];
    this.deliveryDate=json['Delivery_Date'];
    this.totalItem=json['Total_Item'];
    this.order_total=json['Order_Total'];
    this.order_sgst=json['Order_Sgst'];
    this.order_subtotal=json['Order_SubTotal'];
    this.order_igst=json['Order_Igst'];
    this.order_cgst=json['Order_Cgst'];
    Map<Product,int> map= new Map<Product,int>();

    this.order_gst=json['Order_Gst'];
    this.totalItem=json['Total_Item'];
    if (json['Products'] != null) {
      this.products = new List<Product>();
      json['Products'].forEach((v) {
        Product product=Product.fromJson(v);
        products.add(product);
        int selectedquantity=product.selected_quantity;
        Product mapproduct=Product.fromJsonMap(v);
        map[mapproduct]=selectedquantity;
      });
      this.items=map;
    }

  }

  Map<String, Object> toUpdateMap() {
    return {
      'Updated_At': FieldValue.serverTimestamp(),
      'Products': this.products.map((item) {
        return item.toMap();
      }).toList(),
      'Order_Total': this.order_total,
      'Order_SubTotal': this.order_subtotal,
      'Order_Gst': this.order_gst,
      'Order_Cgst': this.order_cgst,
      'Order_Sgst': this.order_sgst,
      'Order_Igst': this.order_igst,
      'Total_Item': this.totalItem
    };
  }
}