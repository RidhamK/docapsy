import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/product.dart';

import 'package:shopapp/provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  // final String title;
  // ProductDetailScreen(this.title);
  static const routeName = 'product-detailpge';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProducts = Provider.of<Products>(context).findBYId(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            margin: const EdgeInsets.all(10),
            child: Hero(
              tag: loadedProducts.id as Object,
              child: Image.network(
                loadedProducts.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '\$${loadedProducts.price}',
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(height: 20),
          Text(
            loadedProducts.description,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
