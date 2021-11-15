// import 'dart:convert';
import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';
import 'package:oilwale/models/productcatalog.dart';
import 'package:oilwale/widgets/ItemWidget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}
class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column (
        children : [
          Container(
            child : TextFormField(
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Search',
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.deepOrange,
                  ),
                  labelStyle: TextStyle(color: Colors.deepOrange),
                  focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange)),
                  hintStyle: TextStyle(color: Colors.deepOrange)),
            ),
          ),
          Container(
                child: Expanded(
                  child: ListView.builder(
                      itemCount: CatalogModel.products.length,
                      itemBuilder: (context, index) {
                        return ItemWidget(
                          item: CatalogModel.products[index],
                        );
                      }),
                ),
              ),

      ]
      ),
    );
  }
}
