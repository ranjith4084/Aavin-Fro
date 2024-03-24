import 'package:aavinposfro/models/product.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem(this.product, this.quantity);

  @override
  String toString() {
    return 'CartItem{product: $product, quantity: $quantity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          product == other.product &&
          quantity == other.quantity;

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  double get total => quantity * product.price;
}
