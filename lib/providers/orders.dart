import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app_2022/providers/cart.dart';
import 'package:http/http.dart' as http;

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
  final String authToken;
  final String userId;
  
  Orders(this.authToken, this.userId ,this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fatchandSetOrders() async {
    final url = Uri.parse(
        'https://food-app-2022-4df84-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final responce = await http.get(url);
    // print(json.decode(responce.body)['name']);
    final List<OrderItem> loadedOrders = [];

    final extractedData = json.decode(responce.body) as Map<String, dynamic>?;
    extractedData?.forEach(
      (orderId, orderVal) {
        loadedOrders.add(
          OrderItem(
              id: orderId,
              amount: orderVal['amount'],
              dateTime: DateTime.parse(orderVal['dateTime']),
              products: (orderVal['products'] as List<dynamic>)
                  .map(
                    (e) => CartItem(
                      id: e['id'],
                      price: e['price'],
                      quantity: e['quantity'],
                      title: e['title'],
                    ),
                  )
                  .toList()),
        );
      },
    );
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrders(List<CartItem> cartProducts, double totle) async {
    final url = Uri.parse(
        'https://food-app-2022-4df84-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timestemp = DateTime.now();

    final responce = await http.post(url,
        body: json.encode({
          'amount': totle,
          'dateTime': timestemp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(responce.body)['name'],
            amount: totle,
            dateTime: timestemp,
            products: cartProducts));
    notifyListeners();
  }
}
