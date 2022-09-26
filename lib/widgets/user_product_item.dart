import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_2022/providers/productss.dart';
import 'package:shop_app_2022/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold =Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () async {
                try {
                 await Provider.of<Products>(context, listen: false)
                      .deleteProducts(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(content: Text('Deleting failed!',textAlign: TextAlign.center)));
                }
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
