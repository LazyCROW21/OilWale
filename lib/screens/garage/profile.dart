import 'dart:core';
import 'package:flutter/material.dart';
import 'package:oilwale/models/garage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Garage garage =Garage(
      referralCode: '',
      pincode: 'loading ..',
      garageId: 'loading ..',
      phoneNumber: 'loading ..',
      area: 'loading ..',
      totaCustomer: 0,
      address: 'loading ..',
      ownerName: 'loading ..',
      totalScore: 0,
      garageName: 'loading ..'
  );

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {

    super.initState();
    SharedPreferences.getInstance().then((garagePreference) {
      setState(()

      {
        garage.garageName =
            garagePreference.getString("garageName") ?? " Not found";
        garage.pincode = garagePreference.getString("pincode") ?? "Not found";
        garage.ownerName = garagePreference.getString("name") ?? " Not found";
        garage.alternateNumber =
            garagePreference.getString("alternateNumber") ?? "Not found";
        garage.phoneNumber =
            garagePreference.getString("phoneNumber") ?? " Not found";
        garage.garageId = garagePreference.getString("garageId") ?? "Not found";
        garage.gstNumber =
            garagePreference.getString("gstNumber") ?? " Not found";
        garage.panCard = garagePreference.getString("panCard") ?? "Not found";
        garage.area = garagePreference.getString("area") ?? " Not found";
        garage.address = garagePreference.getString("address") ?? "Not found";
        garage.referralCode =
            garagePreference.getString("referralCode") ?? "Not found";
        garage.totalScore = garagePreference.getInt("totalScore") ?? 0;
        garage.totaCustomer = garagePreference.getInt("totalCustomer") ?? 0;
      }) ;} );

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(
                    'https://thecinemaholic.com/wp-content/uploads/2021/03/0_iRU5IQ2KGkDyGzyw.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              child: Divider(
                height: 30.0,
                thickness: 1.0,
                color: Colors.orange,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "PanCard",
                            style: TextStyle(color: Colors.orangeAccent[700], fontSize: 13.0),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            garage.panCard ??
                            "-",
                            style:
                            TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                       Column(
                        children: [
                          Text(
                            "GST Number",
                            style: TextStyle(color: Colors.orangeAccent[700], fontSize: 13.0),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            garage.gstNumber ??
                            "-",
                            style:
                            TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
              child: Divider(
                height: 30.0,
                thickness: 1.0,
                color: Colors.orange,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" Garage Name",
                      style: TextStyle(
                          color: Colors.orangeAccent[700], fontSize: 10.0)),
                  Text(
                    garage.garageName ,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(" Owner's Name",
                      style: TextStyle(
                          color: Colors.orangeAccent[700], fontSize: 10.0)),
                  Text(
                    garage.ownerName,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(" Numnber",
                      style: TextStyle(
                          color: Colors.orangeAccent[700], fontSize: 10.0)),
                  Text(
                    garage.phoneNumber,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Alternate Numnber",
                      style: TextStyle(
                          color: Colors.orangeAccent[700], fontSize: 10.0)),
                  Text(
                    garage.alternateNumber ??
                    " -- ",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(" Address",
                      style: TextStyle(
                          color: Colors.orangeAccent[700], fontSize: 10.0)),
                  Text(
                    garage.address ,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Area ",
                      style: TextStyle(
                          color: Colors.orangeAccent[700], fontSize: 10.0)),
                  Text(
                    garage.area ,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(" PinCode",
                      style: TextStyle(
                          color: Colors.orangeAccent[700], fontSize: 10.0)),
                  Text(
                    garage.pincode ,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
