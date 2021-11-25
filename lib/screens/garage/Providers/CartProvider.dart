import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier  {
  int _cartnumprovider = 0;

  int get cartnumprovider => _cartnumprovider;

  void increment() {
    _cartnumprovider++;
  }
  void decrement() {
    _cartnumprovider--;
  }
}