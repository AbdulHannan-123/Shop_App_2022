import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_2022/providers/auth.dart';
import 'package:shop_app_2022/providers/cart.dart';
import 'package:shop_app_2022/providers/orders.dart';
import 'package:shop_app_2022/providers/productss.dart';
import 'package:shop_app_2022/screens/auth_screen.dart';
import 'package:shop_app_2022/screens/cart_screen.dart';
import 'package:shop_app_2022/screens/edit_product_screen.dart';
import 'package:shop_app_2022/screens/orders_screen.dart';
import 'package:shop_app_2022/screens/product_detail_screen.dart';
import 'package:shop_app_2022/screens/product_overview_screen.dart';
import 'package:shop_app_2022/screens/user_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.black,
              secondary: const Color(0xffe7dcd7),
            ),
            accentColor: Color(0xffe7dcd7),
            fontFamily: 'Lato'),
        home: AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductScreen.routeNamae: (context) => UserProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
