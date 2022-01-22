import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilmart/components/garage_tile.dart';
import 'package:oilmart/models/garage.dart';
import 'package:oilmart/service/garage_api.dart';
import 'package:oilmart/theme/themedata.dart';

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
  DateTime lastInp = DateTime.now();
  bool searchAgain = false;

  @override
  void initState() {
    super.initState();
    GarageAPIManager.getAllGarages().then((resp) {
      setState(() {
        isSearching = false;
        _gList = resp;
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
      GarageAPIManager.getAllGarages().then((_result) {
        setState(() {
          _gList = _result;
          isSearching = false;
        });
        if (currentStr != searchQry) {
          buildProductList();
        }
      });
    } else {
      GarageAPIManager.searchGarage(searchQry).then((_result) {
        setState(() {
          _gList = _result;
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
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0), color: Colors.white),
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
                    if (searchQry == "") {
                      return GarageAPIManager.getAllGarages().then((_result) {
                        setState(() {
                          isSearching = false;
                          _gList = _result;
                        });
                      });
                    } else {
                      return GarageAPIManager.searchGarage(searchQry)
                          .then((_result) {
                        setState(() {
                          isSearching = false;
                          _gList = _result;
                        });
                      });
                    }
                  },
                  child: ListView.builder(
                      itemCount: _gList.length,
                      itemBuilder: (context, index) {
                        return GarageTile(garage: _gList[index]);
                      }),
                ),
        ),
      ],
    );
  }
}
