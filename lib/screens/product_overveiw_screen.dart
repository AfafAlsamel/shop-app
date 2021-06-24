import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/app_drawer.dart';
import '../provider/cart.dart';
import '../screens/cart_screen.dart';
import '../widget/badge.dart';
import '../widget/products_grid.dart';

enum filterOptins { Favorit, Alll }

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var _showFavs = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (filterOptins selectedValue) {
              setState(() {
                if (selectedValue == filterOptins.Favorit) {
                  _showFavs = true;
                } else {
                  _showFavs = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only favorite'),
                value: filterOptins.Favorit,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: filterOptins.Alll,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.itemsCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                return Navigator.of(context).pushNamed(CartScreen.namedRoute);
              },
            ),
          ),
        
        ],
        
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavs),
    );
  }
}
