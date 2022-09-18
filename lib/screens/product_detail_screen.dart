import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productss.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productdetailscreen';

  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context)!.settings.arguments as String;
    final loadedproduct =
        Provider.of<Products>(context, listen: false).findById(productid);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedproduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedproduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '\$${loadedproduct.price}',
              style: const TextStyle(color: Colors.black54, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
                child: Text(
              loadedproduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ))
          ],
        ),
      ),
    );
  }
}
