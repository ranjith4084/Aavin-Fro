import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/product.dart';

final productsReducer = combineReducers<List<Product>>([
  TypedReducer<List<Product>, LoadProductsAction>(_setLoadedProducts),
]);

List<Product> _setLoadedProducts(
    List<Product> products, LoadProductsAction action) {
  return action.products;
}
