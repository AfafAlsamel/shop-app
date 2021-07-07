import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_products_screen.dart';

import '/widget/app_drawer.dart';
import '/widget/user_product_item.dart';
import '/provider/products.dart';

class UserProductScreen extends StatelessWidget {
  static const namedRout = '/product-user';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchData(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productData = Provider.of<Products>(context);
    print('rebuilding...');

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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: productsData.item.length,
                          itemBuilder: (_, index) {
                            return Column(children: [
                              UserProductItem(
                                productsData.item[index].id,
                                productsData.item[index].title,
                                productsData.item[index].imageUrl,
                              )
                            ]);
                          },
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
