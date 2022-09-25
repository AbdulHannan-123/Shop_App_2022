import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_2022/providers/productss.dart';
import 'package:shop_app_2022/screens/edit_product_screen.dart';
import 'package:shop_app_2022/widgets/app_drawer.dart';
import 'package:shop_app_2022/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeNamae = '/userproducts';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Your Products'),
        actions: [
          IconButton(onPressed: () {
           Navigator.of(context).pushNamed(EditProductScreen.routeName);
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProductScreen(),));
          },
           icon:const Icon(Icons.add)),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh:()=> _refreshProducts(context),
        child: Padding(
          padding:const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: productsData.items.length,
                  itemBuilder: (_,i)=>UserProductItem(productsData.items[i].id,productsData.items[i].title, productsData.items[i].imageUrl),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}