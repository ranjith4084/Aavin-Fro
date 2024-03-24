class Product {
  String id;
  String name;
  String size;
  double price;
  String documentID;
  double product_basicprice;
  double product_gst;
  double product_cgst;
  double product_igst;
  double product_sgst;
  int selected_quantity;
  String image;
  bool is_gstapplicable;
  String barcode;

  Product(this.id,
      this.name,
      this.size,
      this.price,
      this.product_gst,
      this.product_igst,
      this.product_cgst,
      this.product_sgst,

      this.is_gstapplicable,
      this.product_basicprice,
      this.selected_quantity,
      this.documentID,
      this.barcode,
      this.image,);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              size == other.size &&
              price == other.price&&
              product_gst == other.product_gst&&
              product_igst == other.product_igst&&
              product_cgst ==other.product_cgst &&
              product_sgst== other.product_sgst&&
              image == other.image &&
              barcode == other.barcode &&
              selected_quantity==other.selected_quantity&&
              product_basicprice == other.product_basicprice&&
              documentID==other.documentID&&
              is_gstapplicable ==  other.is_gstapplicable;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image.hashCode^
      size.hashCode ^
      price.hashCode^
      product_gst.hashCode^
      barcode.hashCode^
      product_cgst.hashCode^
      product_igst.hashCode^
      is_gstapplicable.hashCode^
      selected_quantity.hashCode^
      product_basicprice.hashCode^
      documentID.hashCode^
      product_sgst.hashCode;

  @override
  String toString() {
    return 'Product{id: $id,documentid:$documentID, name: $name, selected:$selected_quantity, volume: $size, price: $price,product_gst:$product_gst,product_igst:$product_igst,product_sgst:$product_sgst,product_basicprice:$product_basicprice,product_cgst:$product_cgst}';
  }

  Map<String, Object> toMap() {
    return {
      'Product_Code': id,
      'Product_Name': name,
      'Product_Quantity': size,
      'Product_Price': price,
      'Product_Gst':product_gst,
      'Product_Sgst':product_sgst,
      'Product_Cgst':product_cgst,
      'Product_DocumentID':documentID,
       'Product_Image':image,
      'Product_Igst':product_igst,
      'No_Of_Items':selected_quantity,
      'Product_BasicPrice':product_basicprice,
      'Is_Gst_Applicable':is_gstapplicable,

    };
  }

   Product.fromJson(Map<String, Object> json) {
      this.id=json['Product_Code'];

     this.name=json['Product_Name'];
     this.size=json['Product_Quantity'];
     this.price= json['Product_Price'];
     this.documentID=json['Product_DocumentID'];
     this.product_gst=json['Product_Gst'];
     this.product_sgst=json['Product_Sgst'];
     this.product_cgst=json['Product_Cgst'];
     this.product_igst=json['Product_Igst'];
     this.image=json['Product_Image'];
     this.selected_quantity=json['No_Of_Items'];
       this.product_basicprice=json['Product_BasicPrice'];
    this.is_gstapplicable=json['Is_Gst_Applicable'];

  }
  Product.fromJsonMap(Map<String, Object> json) {
    this.id=json['Product_Code'];

    this.name=json['Product_Name'];
    this.size=json['Product_Quantity'];
    this.price= json['Product_Price'];
    this.product_gst=json['Product_Gst'];
    this.product_sgst=json['Product_Sgst'];
    this.image=json['Product_Image'];
    this.documentID=json['Product_DocumentID'];
    this.product_cgst=json['Product_Cgst'];
    this.product_igst=json['Product_Igst'];
    this.selected_quantity=0;
    this.product_basicprice=json['Product_BasicPrice'];
    this.is_gstapplicable=json['Is_Gst_Applicable'];

  }
}
class Product1 {
  String id;
  String name;
  String size;
  double price;
  String documentID;
  double product_basicprice;
  double product_gst;
  double product_cgst;
  double product_igst;
  double product_sgst;
  int selected_quantity;
  String image;
  bool is_gstapplicable;
  String barcode;

  Product1(this.id,
      this.name,
      this.size,
      this.price,
      this.product_gst,
      this.product_igst,
      this.product_cgst,
      this.product_sgst,

      this.is_gstapplicable,
      this.product_basicprice,
      this.selected_quantity,
      this.documentID,
      this.barcode,
      this.image,);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              size == other.size &&
              price == other.price&&
              product_gst == other.product_gst&&
              product_igst == other.product_igst&&
              product_cgst ==other.product_cgst &&
              product_sgst== other.product_sgst&&
              image == other.image &&
              barcode == other.barcode &&
              selected_quantity==other.selected_quantity&&
              product_basicprice == other.product_basicprice&&
              documentID==other.documentID&&
              is_gstapplicable ==  other.is_gstapplicable;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image.hashCode^
      size.hashCode ^
      price.hashCode^
      product_gst.hashCode^
      barcode.hashCode^
      product_cgst.hashCode^
      product_igst.hashCode^
      is_gstapplicable.hashCode^
      selected_quantity.hashCode^
      product_basicprice.hashCode^
      documentID.hashCode^
      product_sgst.hashCode;

  @override
  String toString() {
    return 'Product{id: $id,documentid:$documentID, name: $name, selected:$selected_quantity, volume: $size, price: $price,product_gst:$product_gst,product_igst:$product_igst,product_sgst:$product_sgst,product_basicprice:$product_basicprice,product_cgst:$product_cgst}';
  }

  Map<String, Object> toMap() {
    return {
      'Product_Code': id,
      'Product_Name': name,
      'Product_Quantity': size,
      'Product_Price': price,
      'Product_Gst':product_gst,
      'Product_Sgst':product_sgst,
      'Product_Cgst':product_cgst,
      'Product_DocumentID':documentID,
      'Product_Image':image,
      'Product_Igst':product_igst,
      'No_Of_Items':selected_quantity,
      'Product_BasicPrice':product_basicprice,
      'Is_Gst_Applicable':is_gstapplicable,

    };
  }

  Product1.fromJson(Map<String, Object> json) {
    this.id=json['Product_Code'];

    this.name=json['Product_Name'];
    this.size=json['Product_Quantity'];
    this.price= json['Product_Price'];
    this.documentID=json['Product_DocumentID'];
    this.product_gst=json['Product_Gst'];
    this.product_sgst=json['Product_Sgst'];
    this.product_cgst=json['Product_Cgst'];
    this.product_igst=json['Product_Igst'];
    this.image=json['Product_Image'];
    this.selected_quantity=json['No_Of_Items'];
    this.product_basicprice=json['Product_BasicPrice'];
    this.is_gstapplicable=json['Is_Gst_Applicable'];

  }
  Product1.fromJsonMap(Map<String, Object> json) {
    this.id=json['Product_Code'];

    this.name=json['Product_Name'];
    this.size=json['Product_Quantity'];
    this.price= json['Product_Price'];
    this.product_gst=json['Product_Gst'];
    this.product_sgst=json['Product_Sgst'];
    this.image=json['Product_Image'];
    this.documentID=json['Product_DocumentID'];
    this.product_cgst=json['Product_Cgst'];
    this.product_igst=json['Product_Igst'];
    this.selected_quantity=0;
    this.product_basicprice=json['Product_BasicPrice'];
    this.is_gstapplicable=json['Is_Gst_Applicable'];

  }
}
