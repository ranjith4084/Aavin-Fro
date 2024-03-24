import 'package:flutter/material.dart';
import 'package:aavinposfro/models/indent.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:aavinposfro/presentation/screens/home/indent/product_card.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatefulWidget {
  final List<Product> products;
  final Stock stock;
  final Cart cart;

  ProductsList(this.products, this.stock, this.cart, {Key key});
//       : super(key: key);
  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xFF1D8DCF),
      body: Container(
        child: widget.products!=null&&widget.products.length > 0
      ? ListView.builder(
      key: new PageStorageKey("products"),
      itemBuilder: (context, index) {
        var product = widget.products[index];
        return Container();

        // return ProductCard(
        //   product,
        //   cartQuantity: widget.cart.items.containsKey(product) ? widget.cart.items[product] : 0,
        //   stockQuantity: widget.stock.items.containsKey(product) ? widget.stock.items[product] : 0,
        // );
      },
//            separatorBuilder: (BuildContext context, int index) {

//            },
      padding: EdgeInsets.only(bottom: 64),
      itemCount: widget.products.length)
      : Center(child: Text("No items found.")),
        decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
      ),
    );
  }
}

// import 'package:aavinposfro/models/indent.dart';
// import 'package:aavinposfro/models/product.dart';
// import 'package:aavinposfro/models/stock.dart';
// import 'package:aavinposfro/presentation/screens/home/indent/product_card.dart';
// import 'package:flutter/material.dart';

// class ProductsList extends StatelessWidget {
//   final List<Product> products;
//   final Stock stock;
//   final Cart cart;

//   ProductsList(this.products, this.stock, this.cart, {Key key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //debugPrint(cart.items.toString());

//     return this.products!=null&&this.products.length > 0
//         ? ListView.builder(
//             key: new PageStorageKey("products"),
//             itemBuilder: (context, index) {
//               var product = this.products[index];

//               return ProductCard(
//                 product,
//                 cartQuantity: cart.items.containsKey(product) ? cart.items[product] : 0,
//                 stockQuantity: stock.items.containsKey(product) ? stock.items[product] : 0,
//               );
//             },
// //            separatorBuilder: (BuildContext context, int index) {

// //            },
//             padding: EdgeInsets.only(bottom: 64),
//             itemCount: this.products.length)
//         : Center(child: Text("No items found."));
//   }
// }
