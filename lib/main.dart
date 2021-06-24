import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/orders.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/orders_screens.dart';

import './provider/products.dart';
import './screens/product_details_screen.dart';
import './screens/product_overveiw_screen.dart';
import './provider/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'App shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: ProductScreen(),
        routes: {
          ProductDetailsScreen.namedRoute: (ctx) => ProductDetailsScreen(),
          CartScreen.namedRoute: (ctx) => CartScreen(),
          OrdersScreen.namedRout: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
