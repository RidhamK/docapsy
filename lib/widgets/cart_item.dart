import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/cart.dart';

class CartWidget extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int qty;
  final String title;

  CartWidget(
    this.id,
    this.productId,
    this.price,
    this.qty,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Sure ? '),
            content: const Text('sure ??'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(child: Text('\$ ${price}')),
            ),
          ),
          title: Text(title),
          subtitle: Text('${price * qty}'),
          trailing: Text('${qty}x'),
        ),
      ),
    );
  }
}
