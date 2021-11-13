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
          padding: EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      child: Icon(isEditing ? Icons.save : Icons.edit))),
              showCustomerForm()
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
                      customer.customerName,
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
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        initialValue:
                            customer != null ? customer!.customerName : '',
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepOrange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepOrange),
                            )),
                      ),
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
          TextFormField(
            initialValue: customer != null ? customer!.customerPhoneNumber : '',
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                )),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            'Address',
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          TextFormField(
            initialValue: customer != null ? customer!.customerAddress : '',
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                )),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            'PINCODE',
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          TextFormField(
            initialValue: customer != null ? customer!.customerPincode : '',
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                )),
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
            'G45H2111',
            style: textStyle('p1', AppColorSwatche.black),
          ),
        ],
      ),
    );
  }
}
