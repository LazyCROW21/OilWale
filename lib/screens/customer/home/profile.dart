import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oilwale/models/customer.dart';
import 'package:oilwale/service/customer_api.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  Customer? undoCustomer;
  Customer customer = Customer(
      active: true,
      createdAt: '',
      customerAddress: 'loading..',
      customerId: 'loading..',
      customerName: 'loading..',
      customerPhoneNumber: 'loading..',
      customerPincode: 'loading..',
      updatedAt: '');

  CustomerDetail? customerDetail;

  @override
  void initState() {
    customerDetail = CustomerDetail(customer);
    super.initState();
    getCustomerPrefs().then((value) {
      setState(() {
        customerDetail = CustomerDetail(customer);
        undoCustomer = new Customer(
            active: customer.active,
            createdAt: '',
            customerAddress: customer.customerAddress,
            customerId: customer.customerId,
            customerName: customer.customerName,
            customerPhoneNumber: customer.customerPhoneNumber,
            customerPincode: customer.customerPincode,
            updatedAt: '');
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget showCustomerForm() {
    if (isEditing) {
      return EditCustomer(customer, setCustomer);
    } else {
      return customerDetail ?? Container();
    }
  }

  Future<void> getCustomerPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    customer.customerName =
        preferences.getString("customerName") ?? 'Not Found!';
    customer.customerPhoneNumber =
        preferences.getString("customerPhoneNumber") ?? 'Not Found!';
    customer.customerAddress =
        preferences.getString("customerAddress") ?? 'Not Found!';
    customer.customerPincode =
        preferences.getString("customerPincode") ?? 'Not Found!';
    customer.garageReferralCode =
        preferences.getString("garageReferralCode") ?? '-';
  }

  void saveCustomerEdit() async {
    bool result = await CustomerAPIManager.updateCustomer(customer);
    if (result) {
      Fluttertoast.showToast(
          msg: "Changes saved!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("customerName", customer.customerName);
      preferences.setString(
          "customerPhoneNumber", customer.customerPhoneNumber);
      preferences.setString("customerAddress", customer.customerAddress);
      preferences.setString("customerPincode", customer.customerPincode);
    } else {
      Fluttertoast.showToast(
          msg: "Error in updating! try later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        customer.customerName = undoCustomer!.customerName;
        customer.customerAddress = undoCustomer!.customerAddress;
        customer.customerPhoneNumber = undoCustomer!.customerPhoneNumber;
        customer.customerPincode = undoCustomer!.customerPincode;
      });
    }
  }

  void setCustomer(Customer editCustomer) {
    this.customer.customerName = editCustomer.customerName;
    this.customer.customerAddress = editCustomer.customerAddress;
    this.customer.customerPhoneNumber = editCustomer.customerPhoneNumber;
    this.customer.customerPincode = editCustomer.customerPincode;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
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
                        if (!isEditing) {
                          saveCustomerEdit();
                        }
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
  final Customer customer;

  CustomerDetail(this.customer, {Key? key}) : super(key: key);

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
                          SharedPreferences.getInstance()
                              .then((SharedPreferences preferences) {
                            preferences.clear();
                          });
                          Navigator.pushNamedAndRemoveUntil(context, '/login',
                              (Route<dynamic> route) {
                            return false;
                          });
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
  final Customer customer;
  final Function(Customer) emitCustomerDetails;
  EditCustomer(this.customer, this.emitCustomerDetails, {Key? key})
      : super(key: key);

  @override
  _EditCustomerState createState() =>
      _EditCustomerState(customer, emitCustomerDetails);
}

class _EditCustomerState extends State<EditCustomer> {
  Customer customer;
  Function(Customer) emitCustomerDetails;
  _EditCustomerState(this.customer, this.emitCustomerDetails);

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
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
                  onChanged: (String inp) {
                    customer.customerName = inp;
                    emitCustomerDetails(customer);
                  },
                  initialValue: customer.customerName,
                  style: textStyle('p1', AppColorSwatche.black),
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
                  onChanged: (String inp) {
                    customer.customerPhoneNumber = inp;
                    emitCustomerDetails(customer);
                  },
                  initialValue: customer.customerPhoneNumber,
                  style: textStyle('p1', AppColorSwatche.black),
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
                  onChanged: (String inp) {
                    customer.customerAddress = inp;
                    emitCustomerDetails(customer);
                  },
                  initialValue: customer.customerAddress,
                  style: textStyle('p1', AppColorSwatche.black),
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
                  onChanged: (String inp) {
                    customer.customerPincode = inp;
                    emitCustomerDetails(customer);
                  },
                  initialValue: customer.customerPincode,
                  style: textStyle('p1', AppColorSwatche.black),
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
