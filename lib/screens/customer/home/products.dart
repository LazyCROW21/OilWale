import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/components/product_tile.dart';
import 'package:oilwale/service/product_api.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ProductListView(),
    );
  }
}

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
  String searchQry = "";
  DateTime lastInp = DateTime.now();
  bool isSearching = true;
  bool searchAgain = false;

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

  void buildProductList() {
    String currentStr = searchQry;
    print('At call: ' + searchQry);
    setState(() {
      isSearching = true;
    });
    if (searchQry == "") {
      ProductAPIManager.getAllProducts().then((_result) {
        setState(() {
          _pList = _result;
          isSearching = false;
        });
        if (currentStr != searchQry) {
          buildProductList();
        }
      });
    } else {
      ProductAPIManager.searchProduct(searchQry).then((_result) {
        setState(() {
          _pList = _result;
          isSearching = false;
        });
        if (currentStr != searchQry) {
          buildProductList();
        }
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
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
              String inpLowercase = input.toLowerCase();
              searchQry = inpLowercase.trim();
              if (isSearching) {
                // searchAgain = true;
                return;
              }
              buildProductList();
            },
            decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                fillColor: Colors.white,
                hintText: 'Search',
                suffixIcon: Icon(
                  Icons.search,
                  color: AppColorSwatche.primary,
                ),
                labelStyle: TextStyle(color: Colors.deepOrange),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: AppColorSwatche.primary,
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
              : RefreshIndicator(
                  onRefresh: () {
                    if (searchQry == "") {
                      return ProductAPIManager.getAllProducts().then((_result) {
                        setState(() {
                          _pList = _result;
                          isSearching = false;
                        });
                      });
                    } else {
                      return ProductAPIManager.searchProduct(searchQry)
                          .then((_result) {
                        setState(() {
                          _pList = _result;
                          isSearching = false;
                        });
                      });
                    }
                  },
                  child: ListView.builder(
                    itemCount: _pList.length,
                    itemBuilder: (context, index) {
                      return ProductTile(product: _pList[index]);
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
