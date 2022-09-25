import 'package:flutter/cupertino.dart';
import 'products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavoritesOnly = false;
  List<Product> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((element) => element.isfavorate).toList();
    // }
    return [
      ..._items
    ]; // adding the ... to make it the copy and send to desired location
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

// void showFavoritesOnly(){
//   _showFavoritesOnly=true;
//   notifyListeners();
// }

// void showAll(){
//   _showFavoritesOnly= false;
//   notifyListeners();
// }

  List<Product> get favList {
    return _items.where((element) => element.isfavorate).toList();
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://food-app-2022-4df84-default-rtdb.firebaseio.com/products.json');
    try {
      final responce = await http.get(url);
      // print(json.decode(responce.body)['name']);
      final extractedData =json.decode(responce.body) as Map<String,dynamic>;
      final List<Product> loadedProducts =[];
      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          isfavorate: value['isFavorite'],
          imageUrl: value['imageUrl']

        ));
       });
       _items=loadedProducts;
       notifyListeners();
    } catch (error) {
      throw (error);
    }
    ;
  }

  Future<void> addProducts(Product product) async {
    final url = Uri.parse(
        'https://food-app-2022-4df84-default-rtdb.firebaseio.com/products.json');
    try {
      final responce = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isfavorate
          }));
      final newProduct = Product(
          id: json.decode(responce.body)['name'],
          description: product.description,
          title: product.title,
          imageUrl: product.imageUrl,
          price: product.price);
      _items.add(newProduct);
      // _items.insert(0,newProduct);    // to insert at the end
      notifyListeners();
    } catch (error) {
      // print(error);
      // throw error;

    }
    // .then((responce) {

    // }).catchError((error) {
    // });
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex > 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProducts(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
