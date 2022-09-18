import 'package:flutter/cupertino.dart';
import 'package:shop_app_2022/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.dateTime,
      required this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> cartProducts, double totle) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: totle,
            dateTime: DateTime.now(),
            products: cartProducts));
    notifyListeners();
  }
}
