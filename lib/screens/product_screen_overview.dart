import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/cart.dart';
import '/provider/products.dart';
import '/screens/cart_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/badge.dart';

import '../widgets/product_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverview extends StatefulWidget {
  const ProductOverview({Key? key}) : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var showOnlyFav = false;
  var _isinit = true;
  var _isloading = false;

  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Products>(context).fetchData(false).then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (selectedValue) => {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  showOnlyFav = true;
                } else {
                  showOnlyFav = false;
                }
              })
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Favorite'),
                value: FilterOptions.Favorites,
              ),
              const PopupMenuItem(
                child: Text('All Items'),
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartitem, widget) => Badge(
              value: cartitem.itemCount.toString(),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.of(context).pushNamed(
                  CartScreen.routeName,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(showOnlyFav),
    );
  }
}
