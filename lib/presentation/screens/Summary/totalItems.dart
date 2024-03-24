import 'package:aavinposfro/models/PointOfSaleOrderModel.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/presentation/widgets/text_with_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
var subtotal=0.0;
var cgst =0.0;
var sgst =0.0;
var total =0.0;

class TotalItems extends StatefulWidget {


  @override
  _TotalItemsState createState() => _TotalItemsState();
}

class _TotalItemsState extends State<TotalItems> {
  @override
  _ViewModel _vm;
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    //var products = this.items.keys.toList();
    subtotal=0.0;
    cgst =0.0;
    sgst =0.0;
    total =0.0;
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
      this._vm = vm;
      return _vm.posSummary==null? Center(
          child: CircularProgressIndicator(),
          )
              :Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[400]))),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 6,
                  child: Text(
                    "Product",
                    style: Theme.of(context).textTheme.subtitle2,
                  )),
              Expanded(
                  flex: 3,
                  child: Center(
                      child: Text("Quantity",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle2))),
              Expanded(
                  flex: 2,
                  child: Center(
                      child: Text("Price",
                          style: Theme.of(context).textTheme.subtitle2))),
            ],
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: _vm.posSummary.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              //  debugPrint("currentproducts"+products[index].toString()+this.items[products[index]].toString());
              var productListRow = ProductListRow(
                product: _vm.posSummary[index],
                // quantity: this.items[index].,
                // key: Key(index.toString()),
              );
              return productListRow;
            }),

      ],
    );});
  }
}

class ProductListRow extends StatefulWidget {
  final PointOfSaleOrder product;
  // final int quantity;




  const ProductListRow({Key key, this.product})
      : super(key: key);

  @override
  _ProductListRowState createState() => _ProductListRowState();
}

class _ProductListRowState extends State<ProductListRow> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),

      child: ListView.builder(
          shrinkWrap: true, // 1st add
          physics: ClampingScrollPhysics(),
          itemCount: widget.product.products.length,
          itemBuilder: (context,index){

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: TextWithTag(
                            text: widget.product.products[index].id,

                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.product.products[index].name,
                            ),
                          ),),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                          widget.product.products[index].selected_quantity.toString(),
                        ))),
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("₹ ${(widget.product.products[index].product_basicprice * widget.product.products[index].selected_quantity).toStringAsFixed(2)}"))),

              ],
            );
          }
      ),
    );
  }
}

class OrderSum extends StatefulWidget {

  @override
  _OrderSumState createState() => _OrderSumState();
}

class _OrderSumState extends State<OrderSum> {
  _ViewModel _vm;
  var subtotal=0.0;
  var cgst =0.0;
  var sgst =0.0;
  var total =0.0;
  addSubTotal(posSummary)
  {
    var subtotal1=0.0;
    for (var element in posSummary)
      {
        for(var e in element.products)
          {
                  subtotal1=e.product_basicprice*e.selected_quantity+subtotal1;
          }
      }
   return subtotal1;
    
  }
  addCgst(posSummary)
  {
    
    var cgst1=0.0;
    for (var element in posSummary)
      {
        for(var e in element.products)
          {
            
                   cgst1=e.product_cgst+cgst1;
          }
      }
   return cgst1;
    
  }
  addSgstTotal(posSummary)
  {
    var sgst1=0.0;

    for (var element in posSummary)
      {
        for(var e in element.products)
          {
                   sgst1=e.product_sgst+sgst1;
          }
      }
   return sgst1;
    
  }
  addTotal(posSummary)
  {
    var total1=0.0;

    for (var element in posSummary)
      {
        total1=total1+element.total;
      }
    
   return total1;
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store){
         // addTotal(store.state.posSummary);
        },
        builder: (context, vm) {
      this._vm = vm;
      return _vm.posSummary==null? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Sub Total",
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("₹ ${addSubTotal(_vm.posSummary).toStringAsFixed(2)}")),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "CGST",
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("₹ ${addCgst(_vm.posSummary).toStringAsFixed(2)}")),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Text("SGST"),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("₹ ${addSgstTotal(_vm.posSummary).toStringAsFixed(2)}")),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Total",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "₹ ${addTotal(_vm.posSummary).toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.headline5,
                  )),
            )
          ],
        )
      ],
    );});
  }
}

class _ViewModel {
  final List posSummary;

  _ViewModel(
      this.posSummary
      );

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      store.state.posSummary
        );
  }
}