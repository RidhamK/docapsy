import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/auth.dart';
import '/provider/cart.dart';
import '/provider/product.dart';

import '/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);
  // String id;
  // String title;
  // String imageUrl;

  // ProductItem(
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // );

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Hero(
            tag: product.id as Object,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: () {
              product.toggeleFav(
                authData.token!,
                authData.userId!,
              );
            },
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id.toString(), product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('add to cart'),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        cart.removeSingleItem(product.id.toString());
                      }),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
