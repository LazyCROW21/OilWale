import 'package:flutter/material.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  bool isEditing = false;
  String? customerId;
  String? customerName;
  String? customerPhoneNumber;
  String? customerAddress;
  String? customerPincode;
  String? garageReferralCode;

  CustomerDetail loadingCustomer = CustomerDetail(
    customerId: 'loading..',
    customerAddress: 'loading..',
    customerName: 'loading..',
    customerPhoneNumber: 'loading..',
    garageReferralCode: 'loading..',
    customerPincode: 'loading..',
  );

  Widget showCustomerForm() {
    if (isLoading) {
      return loadingCustomer;
    } else if (isEditing) {
      return Container();
    } else {
      return Container();
    }
  }

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
          child: showCustomerForm(),
        ));
  }
}

class CustomerDetail extends StatelessWidget {
  late final String customerId;
  late final String customerName;
  late final String customerPhoneNumber;
  late final String customerAddress;
  late final String customerPincode;
  late final String garageReferralCode;
  CustomerDetail(
      {Key? key,
      required this.customerId,
      required this.customerName,
      required this.customerPhoneNumber,
      required this.customerAddress,
      required this.customerPincode,
      required this.garageReferralCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        border: Border.all(color: AppColorSwatche.primary),
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
                      customerName,
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
            customerPhoneNumber,
            style: textStyle('p1', AppColorSwatche.black),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            'Address',
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerAddress,
            style: textStyle('p1', AppColorSwatche.black),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            'PINCODE',
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerPincode,
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
      ),
    );
  }
}
