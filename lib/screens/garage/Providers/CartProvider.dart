import 'package:flutter/material.dart';
import 'package:oilwale/models/product.dart';

class CartProvider with ChangeNotifier  {
  int _cartnumprovider = 0;
  int get cartnumprovider => _cartnumprovider;
  List<Product> cartProduct = [];

  void increment() {
    _cartnumprovider++;
    notifyListeners();
  }
  void decrement() {
    if(_cartnumprovider >0)
    _cartnumprovider--;
    notifyListeners();
  }

}