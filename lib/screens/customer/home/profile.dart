import 'package:flutter/material.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool? active;
  String? customerId;
  String? customerName;
  String? customerPhoneNumber;
  String? customerAddress;
  String? customerPincode;
  String? garageReferralCode;

  Future<void> getCustomerPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    customerName = preferences.getString("customerName");
    customerPhoneNumber = preferences.getString("customerPhoneNumber");
    customerAddress = preferences.getString("customerAddress");
    customerPincode = preferences.getString("customerPincode");
    garageReferralCode = preferences.getString("garageReferralCode");
  }

  @override
  Widget build(BuildContext context) {
    getCustomerPrefs().then((value) {
      setState(() {});
    });
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                  child: Container(
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 72,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(36.0)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: textStyle('p2', AppColorSwatche.primary),
                    ),
                    Text(
                      customerName ?? 'Loading..',
                      style: textStyle('p1', AppColorSwatche.black),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            'Phone',
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerPhoneNumber ?? 'Loading..',
            style: textStyle('p1', AppColorSwatche.black),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            'Address',
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerAddress ?? 'Loading..',
            style: textStyle('p1', AppColorSwatche.black),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            'PINCODE',
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerPincode ?? 'Loading..',
            style: textStyle('p1', AppColorSwatche.black),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            'Total number of time oil serviced',
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            '12',
            style: textStyle('p1', AppColorSwatche.black),
          ),
          Divider(),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Log out",
                    style: textStyle('p1', Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
