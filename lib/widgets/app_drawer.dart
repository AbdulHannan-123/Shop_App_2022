import 'package:flutter/material.dart';
import 'package:shop_app_2022/screens/orders_screen.dart';
import 'package:shop_app_2022/screens/product_overview_screen.dart';
import 'package:shop_app_2022/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Here you are'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading:const Icon(Icons.shop),
            title:const Text("Shop"),
            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductOverViewScreen(),)),
          ), const Divider(),
          ListTile(
            leading:const Icon(Icons.payment),
            title:const Text("Order"),
            onTap: () => Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading:const Icon(Icons.edit),
            title:const Text("Manage Products"),
            onTap: () => Navigator.of(context).pushReplacementNamed(UserProductScreen.routeNamae),
          )
        ],
      ),
    );
  }
}