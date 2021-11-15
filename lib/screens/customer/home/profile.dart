import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oilwale/models/customer.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  bool isEditing = false;
  Customer? customer;
  String customerId = '';
  String customerName = '';
  String customerPhoneNumber = '';
  String customerAddress = '';
  String customerPincode = '';
  String garageReferralCode = '';

  CustomerDetail loadingCustomer = CustomerDetail(
      customer: Customer(
          active: true,
          customerId: 'loading..',
          customerAddress: 'loading..',
          customerName: 'loading..',
          customerPhoneNumber: 'loading..',
          garageReferralCode: 'loading..',
          customerPincode: 'loading..',
          createdAt: '',
          updatedAt: ''));

  Widget showCustomerForm() {
    if (isLoading) {
      return loadingCustomer;
    } else if (isEditing) {
      return EditCustomer();
    } else {
      return CustomerDetail(
          customer: Customer(
              active: true,
              customerId: customerId,
              customerAddress: customerAddress,
              customerName: customerName,
              customerPhoneNumber: customerPhoneNumber,
              garageReferralCode: garageReferralCode,
              customerPincode: garageReferralCode,
              createdAt: '',
              updatedAt: ''));
    }
  }

  Future<void> getCustomerPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    customerName = preferences.getString("customerName") ?? 'Not Found!';
    customerPhoneNumber =
        preferences.getString("customerPhoneNumber") ?? 'Not Found!';
    customerAddress = preferences.getString("customerAddress") ?? 'Not Found!';
    customerPincode = preferences.getString("customerPincode") ?? 'Not Found!';
    garageReferralCode =
        preferences.getString("garageReferralCode") ?? 'Not Found!';
  }

  @override
  Widget build(BuildContext context) {
    getCustomerPrefs().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    return SingleChildScrollView(
      reverse: true,
      child: Container(
          color: Colors.white,
          // padding: EdgeInsets.all(16.0),
          child: Stack(
            children: [
              showCustomerForm(),
              Positioned(
                  top: 0,
                  right: 0,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(
                                  // borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: AppColorSwatche.primary)))),
                      child: Icon(isEditing ? Icons.save : Icons.edit)))
            ],
          )),
    );
  }
}

class CustomerDetail extends StatelessWidget {
  late final Customer customer;

  CustomerDetail({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: <Color>[Colors.deepOrange.shade100, Colors.white],
                    end: Alignment.bottomCenter)),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 72,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColorSwatche.primary),
                    borderRadius: BorderRadius.circular(36.0)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: textStyle('p2', AppColorSwatche.primary),
                ),
                Text(
                  customer.customerName,
                  style: textStyle('p1', AppColorSwatche.black),
                ),
                Divider(),
                SizedBox(height: 10),
                Text(
                  'Phone',
                  style: textStyle('p2', AppColorSwatche.primary),
                ),
                Text(
                  customer.customerPhoneNumber,
                  style: textStyle('p1', AppColorSwatche.black),
                ),
                Divider(),
                SizedBox(height: 10),
                Text(
                  'Address',
                  style: textStyle('p2', AppColorSwatche.primary),
                ),
                Text(
                  customer.customerAddress,
                  style: textStyle('p1', AppColorSwatche.black),
                ),
                Divider(),
                SizedBox(height: 10),
                Text(
                  'PINCODE',
                  style: textStyle('p2', AppColorSwatche.primary),
                ),
                Text(
                  customer.customerPincode,
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
                Text(
                  'Referral Code',
                  style: textStyle('p2', AppColorSwatche.primary),
                ),
                Text(
                  customer.garageReferralCode ?? '-',
                  style: textStyle('p1', AppColorSwatche.black),
                ),
                Divider(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditCustomer extends StatefulWidget {
  final Customer? customer;
  EditCustomer({Key? key, this.customer}) : super(key: key);

  @override
  _EditCustomerState createState() => _EditCustomerState(customer);
}

class _EditCustomerState extends State<EditCustomer> {
  Customer? customer;

  _EditCustomerState(this.customer);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: <Color>[Colors.deepOrange.shade100, Colors.white],
                    end: Alignment.bottomCenter)),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 72,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColorSwatche.primary),
                    borderRadius: BorderRadius.circular(36.0)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: customer != null ? customer!.customerName : '',
                  style: textStyle('p1', AppColorSwatche.primary),
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.deepOrange),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      )),
                ),
                TextFormField(
                  initialValue:
                      customer != null ? customer!.customerPhoneNumber : '',
                  style: textStyle('p1', AppColorSwatche.primary),
                  decoration: const InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Colors.deepOrange),
                      focusColor: Colors.deepOrange,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      )),
                ),
                TextFormField(
                  initialValue:
                      customer != null ? customer!.customerAddress : '',
                  style: textStyle('p1', AppColorSwatche.primary),
                  decoration: const InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(color: Colors.deepOrange),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      )),
                ),
                TextFormField(
                  initialValue:
                      customer != null ? customer!.customerPincode : '',
                  style: textStyle('p1', AppColorSwatche.primary),
                  decoration: const InputDecoration(
                      labelText: 'Pincode',
                      labelStyle: TextStyle(color: Colors.deepOrange),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      )),
                ),
                // Divider(),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Total number of time oil serviced',
                  style: textStyle('p2', AppColorSwatche.primary),
                ),
                Text(
                  '12',
                  style: textStyle('p1', AppColorSwatche.black),
                ),
                Divider(),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Referral Code',
                  style: textStyle('p2', AppColorSwatche.primary),
                ),
                Text(
                  'G45H2111',
                  style: textStyle('p1', AppColorSwatche.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
