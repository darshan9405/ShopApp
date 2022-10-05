import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart' as ord;

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future _ordersFuture;
  Future _obtainFuture() {
    return Provider.of<Orders>(context, listen: false).FetchAndSetOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    _ordersFuture = _obtainFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Your Orders')),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, dataSnapShort) {
            if (dataSnapShort.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapShort.error != null) {
                return Center(
                  child: Text("An Error Occurred!"),
                );
              } else {
                return Consumer<Orders>(builder: ((context, value, child) {
                  return ListView.builder(
                      itemBuilder: (context, index) =>
                          ord.OrderItem(value.orders[index]),
                      itemCount: value.orders.length);
                }));
              }
            }
          },
        ));
  }
}
