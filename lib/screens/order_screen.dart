import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/order.dart';
import '/widgets/app_drawer.dart';
import '/widgets/order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = 'order-screen';

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
  // var _isLoading = false;
  // @override
  // void initState() {
  //   // Future.delayed(Duration.zero).then((_) async {
  //   //   setState(() {
  //   //     _isLoading = true;
  //   //   });
  //   //   await Provider.of<Order>(context, listen: false).fetchAndSet();
  //   //   setState(() {
  //   //     _isLoading = false;
  //   //   });
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Order>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          builder: (ctx, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapShot.error != null) {
                //error handlingc
                return const Center(child: Text('data'));
              } else {
                return Consumer<Order>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemBuilder: (context, index) => OrderWidget(
                      orderData.orders[index],
                    ),
                    itemCount: orderData.orders.length,
                  ),
                );
              }
            }
          },
          future: Provider.of<Order>(context, listen: false).fetchAndSet(),
        )
        //  _isLoading
        //     ? const Center(child: CircularProgressIndicator())
        //     : ListView.builder(
        //         itemBuilder: (context, index) => OrderWidget(
        //           orderData.orders[index],
        //         ),
        //         itemCount: orderData.orders.length,
        //       ),
        );
  }
}
