import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/editProduct_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/userProductItem.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userProducts';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: true);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: ((context, index) => Column(
                  children: [
                    UserProductItem(
                        productsData.items[index].id,
                        productsData.items[index].title,
                        productsData.items[index].imageUrl),
                    Divider()
                  ],
                )),
            itemCount: productsData.items.length,
          ),
        ),
      ),
    );
  }
}
