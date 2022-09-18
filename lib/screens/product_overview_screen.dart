import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_2022/providers/cart.dart';
import 'package:shop_app_2022/screens/cart_screen.dart';
import 'package:shop_app_2022/widgets/app_drawer.dart';
import 'package:shop_app_2022/widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductOverViewScreen extends StatefulWidget {
  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  // final List<Product> _loadedProducts;

  var _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  // productContainer.showFavoritesOnly();
                  _showFavoritesOnly = true;
                } else {
                  // productContainer.showAll();
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(
                child: Text('Only Fvorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
              builder: (_, cartData, ch) => Badge(
                value: cartData.itemCount.toString(),
                child: ch!,
                  ),
                  child: IconButton(
                    icon:const Icon(Icons.shopping_cart),
                    onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
                  ),
                  )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
