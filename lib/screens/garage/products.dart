import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/service/product_api.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:oilwale/widgets/ItemWidget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ProductView(),
    );
  }
}

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: Column(children: [
        Container(
          height: 55.0,
          child: TextFormField(
            onChanged: (String input) {
              print("User entered: " + input);
              String inpLowercase = input.toLowerCase();
              setState(() {
                isSearching = true;
              });
              if (input == "") {
                ProductAPIManager.getAllProducts().then((_result) {
                  setState(() {
                    isSearching = false;
                    _pList = _result;
                  });
                });
              } else {
                ProductAPIManager.searchProduct(inpLowercase).then((_result) {
                  setState(() {
                    isSearching = false;
                    _pList = _result;
                  });
                });
              }
            },
            decoration: InputDecoration(
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
        Container(
          child: Expanded(
            child: isSearching
                ? loadingRing
                : ListView.builder(
                    itemCount: _pList.length,
                    itemBuilder: (context, index) {
                      return ItemWidget(
                        product: _pList[index],
                      );
                    }),
          ),
        ),
      ]),
    );
  }
}
