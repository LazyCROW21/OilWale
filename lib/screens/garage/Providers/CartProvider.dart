import 'package:flutter/material.dart';
import 'package:oilwale/models/product.dart';

class CartProvider with ChangeNotifier  {
  late Product product;
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
  void removeProduct(product) {
    cartProduct.remove(product);
    notifyListeners();
  }
  void addProduct(product) {
    cartProduct.add(product);
    notifyListeners();
  }
}