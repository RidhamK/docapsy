import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

import '/provider/cart.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.price,
    required this.products,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  String? token;
  String? userId;
  Order(this.token, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(double totalAmount, List<CartItem> cartProducts) async {
    // final url = 'https://flutter-update.firebaseio.com/orders.json?auth=$authToken';
    try {
      final url = Uri.parse(
          "https://doctor-ba38d-default-rtdb.firebaseio.com/orders/$userId.json");
      final tTime = DateTime.now();
      final response = await http.post(url,
          body: json.encode({
            'price': totalAmount,
            'dateTime': tTime.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          }));
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          price: totalAmount,
          dateTime: tTime,
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (error) {
      // print(error);
    }
  }

  Future<void> fetchAndSet() async {
    // try {
    final url = Uri.parse(
        "https://doctor-ba38d-default-rtdb.firebaseio.com/orders/$userId.json");
    final response = await http.get(url);
    // print(json.decode(response.body));
    final List<OrderItem> loadedOrder = [];
    final Map<String, dynamic>? extractedData =
        json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrder.add(
        OrderItem(
          id: orderId,
          price: orderData['price'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title']),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrder.reversed.toList();
    notifyListeners();
    // }
    // catch (error) {
    //   // print(error);
    // }
  }
}
