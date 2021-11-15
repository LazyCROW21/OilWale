import 'package:flutter/material.dart';
import 'package:oilwale/components/productlist.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(8.0),
      child: ProductListView(),
    );
  }
}
