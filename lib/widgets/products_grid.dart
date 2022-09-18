import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productss.dart';

import 'product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool showfavs;

  ProductsGrid(this.showfavs);

  @override
  Widget build(BuildContext context) {
    final productsData= Provider.of<Products>(context);
    final product =showfavs? productsData.favList :productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          // create: (BuildContext context) => product[index],
          value: product[index],
          child: ProductItem(
            // product[index].id,
            // product[index].title, 
            // product[index].imageUrl
              ),
        ),
        itemCount: product.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //ammount ot column we want
            childAspectRatio: 3 / 2, // height and width
            crossAxisSpacing: 10, //  spacing between the colums
            mainAxisSpacing: 10 // spacing between the rows
            ));
  }
}
