import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:oilwale/components/product_tile.dart';
import 'package:oilwale/service/product_api.dart';

class ProductListView extends StatefulWidget {
  ProductListView({Key? key}) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  List<Product> _pList = [];

  @override
  void initState() {
    super.initState();
    ProductAPIManager.getProducts().then((resp) {
      _pList = resp;
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: (String input) {
            print("User entered: " + input);
            setState(() async {
              _pList = await ProductAPIManager.getProducts();
              String inpLowercase = input.toLowerCase();
              _pList = _pList.where((p) {
                if (p.name.toLowerCase().contains(inpLowercase)) {
                  return true;
                } else if (p.specification!
                    .toLowerCase()
                    .contains(inpLowercase)) {
                  return true;
                } else {
                  return false;
                }
              }).toList();
            });
          },
          decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: 'Search',
              suffixIcon: Icon(
                Icons.search,
                color: Colors.deepOrange,
              ),
              labelStyle: TextStyle(color: Colors.deepOrange),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.deepOrange,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange)),
              hintStyle: TextStyle(color: Colors.deepOrange)),
        ),
        Expanded(
          // height: (MediaQuery.of(context).size.height - 179),
          child: ListView.builder(
            itemCount: _pList.length,
            itemBuilder: (context, index) {
              return ProductTile(product: _pList[index]);
            },
          ),
        ),
      ],
    );
  }
}
