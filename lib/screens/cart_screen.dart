import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/cart.dart';
import '/provider/order.dart';
import '/screens/order_screen.dart';
import '/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = 'cart-detail';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    var children2 = [
      Text(
        'Total',
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
      const Spacer(),
      Chip(
        label: Text(
          '\$ ${cart.totalAmount.toStringAsFixed(2)}',
          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      OrderButton(cart: cart),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: children2,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => CartWidget(
                  cart.items.values.toList()[index].id,
                  cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].price,
                  cart.items.values.toList()[index].quantity,
                  cart.items.values.toList()[index].title),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount == 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              Provider.of<Order>(context, listen: false).addOrder(
                widget.cart.totalAmount,
                widget.cart.items.values.toList(),
              );
              // Navigator.of(context).pushNamed(OrderScreen.routeName);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
            },
      child: _isLoading
          ? const CircularProgressIndicator()
          : Text(
              'Order Now',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
    );
  }
}
