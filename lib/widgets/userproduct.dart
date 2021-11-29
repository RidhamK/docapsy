import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/products.dart';
import '/screens/edit_product_screen.dart';

class UserProductWidget extends StatefulWidget {
  String id;
  final String imageUrl;
  final String title;
  UserProductWidget(this.id, this.imageUrl, this.title);

  @override
  State<UserProductWidget> createState() => _UserProductWidgetState();
}

class _UserProductWidgetState extends State<UserProductWidget> {
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final a = Provider.of<Products>(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
      ),
      title: Text(widget.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () async {
                Navigator.of(context)
                    .pushNamed(EditProduct.routeName, arguments: widget.id);
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                try {
                  a.delProduct(widget.id);
                } catch (error) {
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'delete failed',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
