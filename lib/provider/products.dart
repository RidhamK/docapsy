import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/modal/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> item = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!--',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //        // ),
  ];

  String? authtoken;
  String? userId;
  // final Product previousProducts;

  Products(
    this.authtoken,
    this.userId,
    this.item,
  );

  List<Product> get items {
    return [...item];
  }

  Product findBYId(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favItems {
    return item.where((element) => element.isFavorite).toList();
  }

  // Future<void> fetchData() async {
  //   var url = Uri.parse(
  //       'https://doctor-ba38d-default-rtdb.firebaseio.com//products.json?auth=$authtoken');
  //   try {
  //     final List<Product> lodadedProd = [];
  //     final response = await http.get(url);
  //     print('response ${response.statusCode}');
  //     print('response ${response.body}');
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     print('a');

  //     url = Uri.parse(
  //         'https://shop-app-cee2b-default-rtd,b.firebaseio.com/userFav/$userId.json?auth=$authtoken');

  //     final favoriteResponse = await http.get(url);
  //     print('FavResponse ${favoriteResponse.statusCode}');
  //     final favoriteData = json.decode(favoriteResponse.body);

  //     extractedData.forEach((key, value) {
  //       lodadedProd.add(Product(
  //         id: key,
  //         description: value['description'],
  //         title: value['title'],
  //         imageUrl: value['imageUrl'],
  //         price: value['price'],
  //         isFavorite: favoriteData == null ? false : favoriteData[key] ?? false,
  //       ));
  //     });

  //     item = lodadedProd;

  //     notifyListeners();
  //   } catch (error) {
  //     print('Proiducts fetch error ');
  //     // rethrow;
  //   }
  // }

  Future<void> fetchData([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="CreatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://doctor-ba38d-default-rtdb.firebaseio.com/products.json?$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      url = Uri.parse(
          'https://doctor-ba38d-default-rtdb.firebaseio.com/userFav/$userId.json');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      // print(favoriteData['-MgeSe-BwJz5HblzVD4T']);

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData['prodId'] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });
      item = loadedProducts;
      print(item.length);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final url = Uri.parse(
          "https://doctor-ba38d-default-rtdb.firebaseio.com//products.json");
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'CreatorId': userId,
          },
        ),
      );
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          description: product.description,
          title: product.title,
          imageUrl: product.imageUrl,
          price: product.price);
      item.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = item.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      final url = Uri.parse(
          "https://doctor-ba38d-default-rtdb.firebaseio.com//products/$id.json}");

      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      item[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> delProduct(String id) async {
    final url = Uri.parse(
        "https://doctor-ba38d-default-rtdb.firebaseio.com//products/$id.json");

    final index = item.indexWhere((prod) => prod.id == id);
    Product? existingProduct = item[index];
    item.removeAt(index);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      item.insert(index, existingProduct);
      notifyListeners();
      throw HttpExtentions('colud not delete product');
    }
    existingProduct = null;
    notifyListeners();
  }
}
