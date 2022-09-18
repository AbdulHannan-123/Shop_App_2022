import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_2022/providers/productss.dart';
import 'package:shop_app_2022/widgets/app_drawer.dart';
import 'package:shop_app_2022/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeNamae = '/userproducts';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Your Products'),
        actions: [
          IconButton(onPressed: () {
            //...
          }, icon:const Icon(Icons.add)),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding:const EdgeInsets.all(8),
        child: Column(
          children: [
            ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (_,i)=>UserProductItem(productsData.items[i].title, productsData.items[i].imageUrl),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}