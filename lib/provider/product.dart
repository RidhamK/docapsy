import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.description,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
  });

  void _setFav(bool newBool) {
    isFavorite = newBool;
    notifyListeners();
  }

  Future<void> toggeleFav(String token, String userId) async {
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        "https://doctor-ba38d-default-rtdb.firebaseio.com/userFav/$userId/$id.json?auth=${token}");
    try {
      final response = await http.put(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFav(oldStatus);
      }
    } catch (error) {
      _setFav(oldStatus);
    }
  }
}
