import 'package:aavinposfro/models/product.dart';
import 'package:flutter/material.dart';
import 'ChosenProducts.dart';

class ProductDetailCard extends StatefulWidget {
  String keyval;
  ViewModel vm;
  ProductDetailCard({this.keyval,this.vm});
  @override
  _ProductDetailCardState createState() => _ProductDetailCardState();
}

class _ProductDetailCardState extends State<ProductDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/aavin_logo_xl.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Text("""Milk\n1000ml"""),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFEFEFEF),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Icon(
                          Icons.remove,
                          size: 18.0,
                        ),
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('10'),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Icon(
                          Icons.add,
                          size: 18.0,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Text('300')
            ],
          ),
        ),
      ),
    );
  }
}
