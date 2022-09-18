import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isfavorate;

  Product(
      {required this.id,
      required this.description,
      required this.title,
      required this.imageUrl,
      this.isfavorate = false,
      required this.price});



  void isToggle(){
    isfavorate= !isfavorate;
    notifyListeners();
  }
}
