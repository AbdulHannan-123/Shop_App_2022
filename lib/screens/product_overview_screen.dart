import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_2022/providers/cart.dart';
import 'package:shop_app_2022/providers/productss.dart';
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
  var _isInit = true;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts();           // this wont work here either you set listen to false
    // Future.delayed(Duration.zero).then((value) => Provider.of<Products>(context).fetchAndSetProducts());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      Provider.of<Products>(context).fetchAndSetProducts(); 
    }
    _isInit=false;
    super.didChangeDependencies();
  }

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
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only Fvorites'),
              ),
              PopupMenuItem(
                value: FilterOptions.All,
                child: Text('show All'),
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
