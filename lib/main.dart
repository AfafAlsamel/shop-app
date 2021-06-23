import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        )
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
        },
      ),
    );
  }
}