import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';
import '../provider/cart.dart';
import '../provider/product.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            return Navigator.of(context).pushNamed(
                ProductDetailsScreen.namedRoute,
                arguments: product.id);
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage(
                'assets\images/product-placeholder.png',
              ),
              image: NetworkImage(
                product.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorit ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.isFavoriteToggle(authData.token, authData.userId);
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('item added to cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeItem(product.id);
                      }),
                ),
              );
              // ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
