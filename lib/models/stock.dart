import 'package:aavinposfro/models/product.dart';
class Stock {
  Map<Product, int> items;
  DateTime updatedAt;

  Stock({Map<Product, int> items, DateTime updatedAt})
      : this.updatedAt = updatedAt ?? DateTime.now(),
        this.items = items ?? new Map<Product, int>();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stock &&
          runtimeType == other.runtimeType &&
          items == other.items &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => items.hashCode ^ updatedAt.hashCode;

  @override
  String toString() {
    return 'Stock{items: $items, lastUpdatedAt: $updatedAt}';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> x = {};

    this.items.forEach((key, value) {
      x.putIfAbsent(key.id, () => value);
    });

//    x.addEntries(this.items.entries.map((e) => {e.key.id: e.value}));
    return x;
  }
}
