import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/auth.dart';
import './screens/splash_screen.dart';
import '/provider/orders.dart';
import '/screens/cart_screen.dart';
import '/screens/edit_products_screen.dart';
import '/screens/orders_screens.dart';
import '/screens/user_product.dart';
import './provider/products.dart';
import './screens/product_details_screen.dart';
import './screens/product_overveiw_screen.dart';
import './provider/cart.dart';
import './screens/auth_screen.dart';

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
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previouseProduct) => Products(
                auth.token,
                auth.userId,
                previouseProduct == null ? [] : previouseProduct.item),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previouseProduct) => Orders(
                auth.token,
                auth.userId,
                previouseProduct == null ? [] : previouseProduct.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
             
            ),
            home: auth.isAuth
                ? ProductScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductDetailsScreen.namedRoute: (ctx) => ProductDetailsScreen(),
              CartScreen.namedRoute: (ctx) => CartScreen(),
              OrdersScreen.namedRout: (ctx) => OrdersScreen(),
              UserProductScreen.namedRout: (ctx) => UserProductScreen(),
              EditUserProductScreen.namedRout: (ctx) => EditUserProductScreen(),
            },
          ),
        ));
  }
}
