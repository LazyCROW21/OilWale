import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilwale/components/garage_tile.dart';
import 'package:oilwale/models/garage.dart';
import 'package:oilwale/service/garage_api.dart';
import 'package:oilwale/theme/themedata.dart';

class GarageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GarageListView(),
    );
  }
}

class GarageListView extends StatefulWidget {
  GarageListView({Key? key}) : super(key: key);

  @override
  _GarageListViewState createState() => _GarageListViewState();
}

class _GarageListViewState extends State<GarageListView> {
  List<Garage> _gList = [];
  SpinKitRing loadingRing = SpinKitRing(
    color: AppColorSwatche.primary,
  );
  String searchQry = "";
  bool isSearching = true;
  final GlobalKey<AnimatedListState> _garageListKey =
      GlobalKey<AnimatedListState>();
  final Tween<double> _tween = Tween<double>(begin: 0.5, end: 1.0);

  @override
  void initState() {
    super.initState();
    GarageAPIManager.getAllGarages().then((resp) {
      setState(() {
        isSearching = false;
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          Future ft = Future(() {});
          for (int i = 0; i < resp.length; i++) {
            ft = ft.then((value) {
              return Future.delayed(Duration(milliseconds: 100), () {
                _gList.add(resp[i]);
                _garageListKey.currentState!
                    .insertItem(i, duration: Duration(milliseconds: 200));
              });
            });
          }
        });
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
    for (var i = 0; i < _gList.length; i++) {
      _garageListKey.currentState!.removeItem(0,
          (BuildContext context, Animation<double> animation) {
        return Container();
      });
    }
    _gList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0), color: Colors.white),
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
                GarageAPIManager.getAllGarages().then((_result) {
                  setState(() {
                    isSearching = false;
                    // _pList = _result;
                    Future ft = Future(() {});
                    for (int i = 0; i < _result.length; i++) {
                      ft = ft.then((value) {
                        return Future.delayed(Duration(milliseconds: 100), () {
                          _gList.add(_result[i]);
                          _garageListKey.currentState!.insertItem(i,
                              duration: Duration(milliseconds: 200));
                        });
                      });
                    }
                  });
                });
              } else {
                GarageAPIManager.searchGarage(inpLowercase).then((_result) {
                  setState(() {
                    isSearching = false;
                    Future ft = Future(() {});
                    for (int i = 0; i < _result.length; i++) {
                      ft = ft.then((value) {
                        return Future.delayed(Duration(milliseconds: 100), () {
                          _gList.add(_result[i]);
                          _garageListKey.currentState!.insertItem(i,
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
              hintText: 'Search',
              suffixIcon: Icon(
                Icons.search,
                color: AppColorSwatche.primary,
              ),
              labelStyle: TextStyle(color: AppColorSwatche.primary),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: BorderSide(
                  color: AppColorSwatche.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(color: AppColorSwatche.primary)),
              hintStyle: TextStyle(color: AppColorSwatche.primary),
            ),
          ),
        ),
        Expanded(
          // height: (MediaQuery.of(context).size.height - 179),
          child: isSearching
              ? loadingRing
              : RefreshIndicator(
                  onRefresh: () {
                    _clearAllItems();
                    if (searchQry == "") {
                      return GarageAPIManager.getAllGarages().then((_result) {
                        setState(() {
                          isSearching = false;
                          Future ft = Future(() {});
                          for (int i = 0; i < _result.length; i++) {
                            ft = ft.then((value) {
                              return Future.delayed(Duration(milliseconds: 100),
                                  () {
                                _gList.add(_result[i]);
                                _garageListKey.currentState!.insertItem(i,
                                    duration: Duration(milliseconds: 200));
                              });
                            });
                          }
                        });
                      });
                    } else {
                      return GarageAPIManager.searchGarage(searchQry)
                          .then((_result) {
                        setState(() {
                          isSearching = false;
                          Future ft = Future(() {});
                          for (int i = 0; i < _result.length; i++) {
                            ft = ft.then((value) {
                              return Future.delayed(Duration(milliseconds: 100),
                                  () {
                                _gList.add(_result[i]);
                                _garageListKey.currentState!.insertItem(i,
                                    duration: Duration(milliseconds: 200));
                              });
                            });
                          }
                        });
                      });
                    }
                  },
                  child: AnimatedList(
                      key: _garageListKey,
                      initialItemCount: _gList.length,
                      itemBuilder: (context, index, animation) {
                        return SizeTransition(
                            sizeFactor: animation.drive(_tween),
                            child: GarageTile(garage: _gList[index]));
                      }),
                ),
        ),
      ],
    );
  }
}
