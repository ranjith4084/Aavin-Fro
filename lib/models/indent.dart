import 'package:aavinposfro/models/product.dart';

import 'PriceModel.dart';

class Cart {
  Map<Product, int> items;

  Cart(this.items);

  PriceModel get total {
    double basic_price = 0;
    double total_price=0;

    double cgst=0;
    double igst=0;
    double sgst=0;
    double gst=0;
    //double basic_price=0;
    items.forEach((key, value) {
      total_price = total_price + (key.price * value);
      cgst = cgst + (key.product_cgst * value);
      sgst=sgst+(key.product_sgst*value);
      igst=igst + (key.product_igst * value);
      gst=gst+(key.product_gst*value);
      basic_price=basic_price+(key.product_basicprice*value);
    });
    PriceModel priceModel=PriceModel(gst,sgst,cgst,igst,basic_price,total_price);
    return priceModel;
  }
}
