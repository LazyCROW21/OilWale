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
    color: AppColorSwatche.white,
  );
  bool isSearching = true;

  @override
  void initState() {
    super.initState();
    GarageAPIManager.getAllGarages().then((_result) {
      setState(() {
        isSearching = false;
        _gList = _result;
      });
    });
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
              print("User entered: " + input);
              String inpLowercase = input.toLowerCase();
              setState(() {
                isSearching = true;
              });
              if (input == "") {
                GarageAPIManager.getAllGarages().then((_result) {
                  setState(() {
                    isSearching = false;
                    _gList = _result;
                  });
                });
              } else {
                GarageAPIManager.searchGarage(inpLowercase).then((_result) {
                  setState(() {
                    isSearching = false;
                    _gList = _result;
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
              : ListView.builder(
                  itemCount: _gList.length,
                  itemBuilder: (context, index) {
                    return GarageTile(garage: _gList[index]);
                  },
                ),
        ),
      ],
    );
  }
}
