import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/presentation/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class EditProductCard extends StatefulWidget {
  final Product product;
  final int cartQuantity;
  final int stockQuantity;

  const EditProductCard(this.product,
      {int cartQuantity, int stockQuantity, Key key})
      : this.cartQuantity = cartQuantity ?? 0,
        this.stockQuantity = stockQuantity ?? 0,
        super(key: key);

  @override
  _EditProductCardState createState() => _EditProductCardState();
}

class _EditProductCardState extends State<EditProductCard> {
  _ViewModel vm;
  TextEditingController _quantityEditingController;

  @override
  void initState() {
    _quantityEditingController = TextEditingController(
        text: widget.cartQuantity == 0 ? null : widget.cartQuantity.toString());
    _quantityEditingController.addListener(() {
      int quantity = _quantityEditingController.text.isEmpty
          ? null
          : int.tryParse(_quantityEditingController.text);
    //  vm.updateCart(widget.product, quantity);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          this.vm = vm;
          return Container(
//            color: Colors.grey[200],
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Wrap(
                      spacing: 8,
                      children: <Widget>[
                        Tag(
                          label: Text(
                            widget.product.id,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Tag(
                          label: Text("₹",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          child: Text(widget.product.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                          color: Colors.blue[400],
                        ),
                        if (widget.stockQuantity > 0)
                          Tag(
                            label: Icon(
                              Icons.store_mall_directory,
                              color: Colors.white,
                              size: 14,
                            ),
                            child: Text(widget.stockQuantity.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                            color: Colors.green[400],
                          )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 64,
                      child: QuantityField(
                        controller: _quantityEditingController,
                      ),
                    ),
                    if (widget.cartQuantity > 0)
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 4,
                          ),
                          Text(" ${widget.product.price * widget.cartQuantity}")
                        ],
                      )
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _quantityEditingController.dispose();
    super.dispose();
  }
}

class QuantityField extends StatelessWidget {
//  final _formKey = GlobalKey<FormState>();

  final TextEditingController controller;

  const QuantityField({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
//      Form(
//      key: _formKey,
//      autovalidate: true,
//      child:
      TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3)
        ],
        validator: (input) {
          var quantity = int.tryParse(input) ?? 0;
          if (input.length > 0 && quantity < 1) {
            return "Invalid";
          } else
            return null;
        },
        decoration: InputDecoration(
            hintText: "0",
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(gapPadding: 1)),
      );
//    );
  }
}

class _ViewModel {
 // final Function(String product, int quantity) updateCart;

  _ViewModel();

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel();
  }
}
