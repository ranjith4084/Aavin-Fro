import 'dart:developer';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/presentation/widgets/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ItemCard extends StatefulWidget {
  final Product product;
  final int stockQuantity;
  final int draftQuantity;
  final bool isEditable;

  const ItemCard(this.product,
      {Key key, this.stockQuantity, this.draftQuantity, bool isEditable})
      : this.isEditable = isEditable ?? false,
        super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  TextEditingController _quantityEditingController;
  _ViewModel _vm;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _quantityEditingController = TextEditingController();

    _quantityEditingController.addListener(() {
      log("${widget.product.name} : ${_quantityEditingController.text}");
      int quantity = _quantityEditingController.text.isEmpty
          ? null
          : int.tryParse(_quantityEditingController.text);
      _vm.updateStock(widget.product, quantity);
    });
  }

  @override
  void dispose() {
    _quantityEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        this._vm = vm;
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Wrap(
                direction: Axis.vertical,
                spacing: 4,
                children: <Widget>[
                  Text(
                    widget.product.name,
                  ),
                  Tag(
                      label: Text("${widget.product.id}",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ],
              ),
              Column(
                children: <Widget>[
                  widget.isEditable
                      ? Container(
                          width: 64,
                          child: Form(
                            autovalidateMode: AutovalidateMode.always, key: _formKey,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(gapPadding: 1),
                                  hintText: widget.stockQuantity.toString(),
                                  contentPadding: EdgeInsets.all(8),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          fontSize: 16, color: Colors.grey),
                                  alignLabelWithHint: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
//                              validator: (input) {
//                                int quantity = int.tryParse(
//                                        input.isEmpty || input == null
//                                            ? widget.item.quantity.toString()
//                                            : (input)) ??
//                                    0;
//                                return quantity > widget.item.quantity
//                                    ? "INVALID"
//                                    : null;
//                              },
                              keyboardType: TextInputType.phone,
                              controller: _quantityEditingController,
                            ),
                          ),
                        )
                      : Text(
                          widget.stockQuantity.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontSize: 32, color: Colors.grey),
                        ),
                  widget.isEditable
                      ? SizedBox.shrink()
                      : Text(
                          "IN-STOCK",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 10, color: Colors.green),
                        ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final Function(Product product, int quantity) updateStock;

  _ViewModel(this.updateStock);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel((Product product, int quantity) =>
        store.dispatch(UpdateStockAction(product, quantity)));
  }
}
