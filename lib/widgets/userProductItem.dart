import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/editProduct_screen.dart';
import '../providers/products.dart';
// import '../providers/product.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String url;
  final String id;
  UserProductItem(this.id, this.title, this.url);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(url),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              )),
          IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text(
                      'Deleting failed!',
                      textAlign: TextAlign.center,
                    ),
                  ));
                }
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              )),
        ],
      ),
    );
  }
}
