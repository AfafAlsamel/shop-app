import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import './product_item.dart';
import '../provider/product.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts = showFavs ? productsData.favItems:productsData.item;
    return  Container(
        margin: EdgeInsets.all(10),
        child: GridView.builder(
          itemBuilder: (ctx, index) {
            return ChangeNotifierProvider.value(
              value :loadedProducts[index],
              child: ProductItem(
              // loadedProducts[index].id,
              // loadedProducts[index].title,
              // loadedProducts[index].imageUrl,
            ),);
          
          },
          itemCount: loadedProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
        ),
      
    );
  }
}
