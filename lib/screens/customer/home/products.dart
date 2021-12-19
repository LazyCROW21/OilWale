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
  bool isSearching = true;
  final GlobalKey<AnimatedListState> _productListKey =
      GlobalKey<AnimatedListState>();
  final Tween<double> _tween = Tween<double>(begin: 0.5, end: 1.0);

  @override
  void initState() {
    super.initState();
    ProductAPIManager.getAllProducts().then((resp) {
      setState(() {
        isSearching = false;
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          Future ft = Future(() {});
          for (int i = 0; i < resp.length; i++) {
            ft = ft.then((value) {
              return Future.delayed(Duration(milliseconds: 100), () {
                _pList.add(resp[i]);
                _productListKey.currentState!
                    .insertItem(i, duration: Duration(milliseconds: 200));
              });
            });
          }
        });
        // _pList = resp;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _clearAllItems() {
    for (var i = 0; i < _pList.length; i++) {
      _productListKey.currentState!.removeItem(0,
          (BuildContext context, Animation<double> animation) {
        return Container();
      });
    }
    _pList.clear();
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
              String inpLowercase = input.toLowerCase();
              setState(() {
                isSearching = true;
              });
              searchQry = input;
              _clearAllItems();
              if (input == "") {
                ProductAPIManager.getAllProducts().then((_result) {
                  setState(() {
                    isSearching = false;
                    // _pList = _result;
                    Future ft = Future(() {});
                    for (int i = 0; i < _result.length; i++) {
                      ft = ft.then((value) {
                        return Future.delayed(Duration(milliseconds: 100), () {
                          _pList.add(_result[i]);
                          _productListKey.currentState!.insertItem(i,
                              duration: Duration(milliseconds: 200));
                        });
                      });
                    }
                  });
                });
              } else {
                ProductAPIManager.searchProduct(inpLowercase).then((_result) {
                  setState(() {
                    isSearching = false;
                    Future ft = Future(() {});
                    for (int i = 0; i < _result.length; i++) {
                      ft = ft.then((value) {
                        return Future.delayed(Duration(milliseconds: 100), () {
                          _pList.add(_result[i]);
                          _productListKey.currentState!.insertItem(i,
                              duration: Duration(milliseconds: 200));
                        });
                      });
                    }
                  });
                });
              }
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
                    _clearAllItems();
                    if (searchQry == "") {
                      return ProductAPIManager.getAllProducts().then((_result) {
                        setState(() {
                          isSearching = false;
                          // _pList = _result;
                          Future ft = Future(() {});
                          for (int i = 0; i < _result.length; i++) {
                            ft = ft.then((value) {
                              return Future.delayed(Duration(milliseconds: 100),
                                  () {
                                _pList.add(_result[i]);
                                _productListKey.currentState!.insertItem(i,
                                    duration: Duration(milliseconds: 200));
                              });
                            });
                          }
                        });
                      });
                    } else {
                      return ProductAPIManager.searchProduct(searchQry)
                          .then((_result) {
                        setState(() {
                          isSearching = false;
                          Future ft = Future(() {});
                          for (int i = 0; i < _result.length; i++) {
                            ft = ft.then((value) {
                              return Future.delayed(Duration(milliseconds: 100),
                                  () {
                                _pList.add(_result[i]);
                                _productListKey.currentState!.insertItem(i,
                                    duration: Duration(milliseconds: 200));
                              });
                            });
                          }
                        });
                      });
                    }
                  },
                  child: AnimatedList(
                    key: _productListKey,
                    initialItemCount: _pList.length,
                    itemBuilder: (context, index, animation) {
                      return SizeTransition(
                          sizeFactor: animation.drive(_tween),
                          child: ProductTile(product: _pList[index]));
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
