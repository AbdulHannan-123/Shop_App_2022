import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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



  Future<void> isToggle()async{
    final oldStatus = isfavorate;
    isfavorate= !isfavorate;
    notifyListeners();
      final url = Uri.parse(
        'https://food-app-2022-4df84-default-rtdb.firebaseio.com/products/$id.json');
        try{
          await http.patch(url, body: json.encode({
            'isFavorite': isfavorate
          }));
        } catch(error){
          isfavorate=oldStatus;
          notifyListeners();
        }
  }
}
