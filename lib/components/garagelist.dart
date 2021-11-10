import 'package:flutter/material.dart';
import 'package:oilwale/components/garage_tile.dart';
import 'package:oilwale/models/garage.dart';
import 'package:oilwale/service/garage_api.dart';
import 'package:oilwale/theme/themedata.dart';

class GarageListView extends StatefulWidget {
  GarageListView({Key? key}) : super(key: key);

  @override
  _GarageListViewState createState() => _GarageListViewState();
}

class _GarageListViewState extends State<GarageListView> {
  List<Garage> _gList = [];

  @override
  void initState() {
    super.initState();
    GarageAPIManager.getAllGarages().then((_result) {
      setState(() {
        _gList = _result;
      });
    });
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
              // setState(() {
              //   String inpLowercase = input.toLowerCase();
              //   _gList = allGarages.where((g) {
              //     if (g.garageName.toLowerCase().contains(inpLowercase)) {
              //       return true;
              //     } else if (g.pincode.toLowerCase().contains(inpLowercase)) {
              //       return true;
              //     } else if (g.address.toLowerCase().contains(inpLowercase)) {
              //       return true;
              //     } else {
              //       return false;
              //     }
              //   }).toList();
              // });
            },
            decoration: InputDecoration(
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
          child: ListView.builder(
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
