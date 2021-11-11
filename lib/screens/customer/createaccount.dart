import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oilwale/service/customer_api.dart';
import 'package:oilwale/theme/themedata.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String? _name;
  String? _phone;
  String? _addr;
  String? _pin;
  String? _refcode;

  // constants
  final double _textInputfontSize = 16.0;
  final TextStyle _customTStyle = TextStyle(color: AppColorSwatche.primary);
  final OutlineInputBorder _customOutlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
    borderSide: BorderSide(
      color: AppColorSwatche.primary,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  onChanged: (String? inp) {
                    _name = inp;
                  },
                  style: TextStyle(fontSize: _textInputfontSize),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColorSwatche.primary,
                    ),
                    hintText: 'Your name',
                    labelText: 'Enter name',
                    labelStyle: _customTStyle,
                    focusedBorder: _customOutlineBorder,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: AppColorSwatche.primary)),
                    hintStyle: _customTStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  onChanged: (String? inp) {
                    this._phone = inp;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: TextStyle(fontSize: _textInputfontSize),
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.person, color: AppColorSwatche.primary),
                    hintText: 'Your phone',
                    labelText: 'Enter phone',
                    labelStyle: _customTStyle,
                    focusedBorder: _customOutlineBorder,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: AppColorSwatche.primary)),
                    hintStyle: _customTStyle,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    onChanged: (String? inp) {
                      this._addr = inp;
                    },
                    maxLines: 4,
                    style: TextStyle(fontSize: _textInputfontSize),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: AppColorSwatche.primary,
                      ),
                      hintText: 'xyz society, abc area ...',
                      labelText: 'Enter address',
                      labelStyle: _customTStyle,
                      focusedBorder: _customOutlineBorder,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          borderSide:
                              BorderSide(color: AppColorSwatche.primary)),
                      hintStyle: _customTStyle,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  onChanged: (String? inp) {
                    this._pin = inp;
                  },
                  style: TextStyle(fontSize: _textInputfontSize),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.fiber_pin_outlined,
                      color: AppColorSwatche.primary,
                    ),
                    hintText: '000000',
                    labelText: 'PINCODE',
                    labelStyle: _customTStyle,
                    focusedBorder: _customOutlineBorder,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: AppColorSwatche.primary)),
                    hintStyle: _customTStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  onChanged: (String? inp) {
                    this._refcode = inp;
                  },
                  style: TextStyle(fontSize: _textInputfontSize),
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.code, color: AppColorSwatche.primary),
                    hintText: 'REFERRALCODE',
                    labelText: 'Referral code (optional)',
                    labelStyle: _customTStyle,
                    focusedBorder: _customOutlineBorder,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: AppColorSwatche.primary)),
                    hintStyle: _customTStyle,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> data = new Map();
                  data['customerName'] = _name;
                  data['customerPhoneNumber'] = _phone;
                  data['customerPincode'] = _pin;
                  data['garageReferralCode'] = _refcode;
                  data['customerAddress'] = _addr;
                  CustomerAPIManager.addCustomer(data);
                  // Navigator.pushNamed(context, '/cust_addvehicle');
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                    // textStyle: MaterialStateProperty.all<TextStyle>(
                    //     TextStyle(fontSize: 20.0)),
                    fixedSize: MaterialStateProperty.all(
                        Size.fromWidth(MediaQuery.of(context).size.width))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Create Account',
                    style: textStyle('p1', Colors.white),
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
