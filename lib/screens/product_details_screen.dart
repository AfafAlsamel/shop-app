import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/products.dart';

class ProductDetailsScreen extends StatelessWidget {
      static const namedRoute= '/product-details';

  @override
  Widget build(BuildContext context) {

    final String productId =ModalRoute.of(context).settings.arguments as String ;

    final choosenProduct = Provider.of<Products>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(choosenProduct.title),
      ),
    );
  }
}
