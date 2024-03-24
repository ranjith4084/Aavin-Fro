import 'indent.dart';

class Order {
  String id;
  Cart cart;
  DateTime timestamp;
  DateTime deliveryDate;
  OrderStatus status;
  PaymentMode paymentMode;
  String deliveryAddress;

  Order(this.cart,
      {this.id,
      DateTime timestamp,
      this.deliveryDate,
      this.status,
      PaymentMode paymentMode,
      this.deliveryAddress})
      : this.timestamp = timestamp ?? DateTime.now(),
        this.paymentMode = paymentMode ?? PaymentMode.cashOnDelivery;

  double calculateTax(double total, double percent) => total * (percent / 100);

  double get cgst => this.cart.total.total_cgst;

  double get sgst => this.cart.total.total_sgst;

  get total {
    return this.cart.total.total_basicprice + this.cgst + this.sgst;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          cart == other.cart &&
          timestamp == other.timestamp &&
          deliveryDate == other.deliveryDate &&
          status == other.status &&
          paymentMode == other.paymentMode &&
          deliveryAddress == other.deliveryAddress;

  @override
  int get hashCode =>
      id.hashCode ^
      cart.hashCode ^
      timestamp.hashCode ^
      deliveryDate.hashCode ^
      status.hashCode ^
      paymentMode.hashCode ^
      deliveryAddress.hashCode;

  @override
  String toString() {
    return 'Order{id: $id, cart: $cart, timestamp: $timestamp, deliveryDate: $deliveryDate, status: $status, paymentMode: $paymentMode, deliveryAddress: $deliveryAddress}';
  }

  String getOrderStatusAsString() {
    switch (this.status) {
      case OrderStatus.accepted:
        return "Accepted";
        break;
      case OrderStatus.placed:
        return "Placed";
        break;
      case OrderStatus.requested:
        return "Requested";
        break;
      case OrderStatus.delivered:
        return "Delivered";
        break;
      case OrderStatus.draft:
        return "In-Cart";
        break;
      default:
        return "Failed";
    }
  }
}

enum OrderStatus { draft, requested, accepted, delivered,placed }
enum PaymentMode { cashOnDelivery, onlinePayment }
