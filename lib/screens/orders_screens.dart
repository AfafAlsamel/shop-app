import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widget/app_drawer.dart';

import '../provider/orders.dart' show Orders;
import '../widget/orders_items.dart';

class OrdersScreen extends StatelessWidget {
  static const namedRout = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
