import 'dart:core';
import 'package:flutter/material.dart';
import 'package:oilwale/models/garage.dart';
import 'package:oilwale/service/garage_api.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Garage garage = Garage(
      totalScore: 0,
      ownerName: 'Chunnilaal',
      address: 'Chunilaaal ka ghar , munnilaal k ghar k saamne ,laalnagar , laalbaad, laaldesh',
      area: 'Laalnagar',
      totaCustomer: 0,
      garageName: 'Chunnilaal ka garage',
      phoneNumber: '1234567892',
      garageId: '',
      referralCode: 'ASDFG986',
      pincode: '382330',
      panCard: 'AGXP7892F',
      gstNumber: 'ASDFGHj120988123'
  );
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
                    garage.garageName ??
                    "-",
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
                    garage.ownerName??
                    "-",
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
                    garage.phoneNumber ??
                    " 8781115157 ",
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
                    garage.address ??
                    "-",
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
                    garage.area ??
                    "-",
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
                    garage.pincode ??
                    "-",
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
