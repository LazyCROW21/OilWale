import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/components/product_tile.dart';
import 'package:oilwale/service/product_api.dart';

class ProductListView extends StatefulWidget {
  ProductListView({Key? key}) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  List<Product> _pList = [];
  SpinKitRing loadingRing = SpinKitRing(
    color: AppColorSwatche.primary,
  );
  bool isSearching = true;

  @override
  void initState() {
    super.initState();
    ProductAPIManager.getAllProducts().then((resp) {
      setState(() {
        isSearching = false;
        _pList = resp;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24.0)),
          padding: EdgeInsets.all(4.0),
          child: TextFormField(
            onChanged: (String input) {
              print("User entered: " + input);
              setState(() async {
                _pList = await ProductAPIManager.getAllProducts();
                String inpLowercase = input.toLowerCase();
                _pList = _pList.where((p) {
                  if (p.name.toLowerCase().contains(inpLowercase)) {
                    return true;
                  } else if (p.specification
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
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: Colors.deepOrange,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(color: AppColorSwatche.primary)),
                hintStyle: textStyle('p1', AppColorSwatche.primary)),
          ),
        ),
        Expanded(
          child: isSearching
              ? loadingRing
              : ListView.builder(
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
