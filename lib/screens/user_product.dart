import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_products_screen.dart';

import '/widget/app_drawer.dart';
import '/widget/user_product_item.dart';
import '/provider/products.dart';

class UserProductScreen extends StatelessWidget {
  static const namedRout = '/product-user';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditUserProductScreen.namedRout);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: productData.item.length,
            itemBuilder: (_, index) {
              return Column(children: [
                UserProductItem(
                  productData.item[index].id,
                  productData.item[index].title,
                  productData.item[index].imageUrl,
                )
              ]);
            },
          ),
        ),
      ),
    );
  }
}
