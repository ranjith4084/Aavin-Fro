import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/presentation/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class UpdatedStockSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        var items = vm.updatedStock.keys.toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
//                  ClipOval(
//                    child: Material(
//                      color: Colors.grey,
//                      child: Padding(
//                        padding: const EdgeInsets.all(4.0),
//                        child: Icon(
//                          Icons.update,
//                          color: Colors.white,
//                          size: Theme.of(context).textTheme.subtitle1.fontSize -
//                              4,
//                        ),
//                      ),
//                    ),
//                  ),
                    Icon(
                      Icons.update,
                      color: Colors.grey,
                      size: Theme.of(context).textTheme.subtitle1.fontSize,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Updated Items".toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
//                  SizedBox(
//                    width: 8,
//                  ),
//                  Expanded(
//                    child: Divider(
//                      height: 5,
//                      color: Colors.grey,
//                    ),
//                  )
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(bottom: 96),
              itemBuilder: (context, index) {
                var product = items[index];

                return UpdatedStockRow(
                  product: product,
                  quantity: vm.updatedStock[product],
                );
              },
            )
          ],
        );
      },
    );
  }
}

class UpdatedStockRow extends StatelessWidget {
  final Product product;
  final int quantity;

  const UpdatedStockRow({Key key, this.product, this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.product.name),
              SizedBox(height: 4),
              Tag(
                  label: Text("${this.product.id}",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)))
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                this.quantity.toString(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "ITEMS",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 10),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ViewModel {
  final Map<Product, int> updatedStock;

  _ViewModel(this.updatedStock);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.updatedStock);
  }
}
