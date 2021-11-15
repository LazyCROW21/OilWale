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
  String? _pwd;
  String? _confpwd;

  // constants
  final double _textInputfontSize = 16.0;
  final TextStyle _customTStyle = TextStyle(color: AppColorSwatche.primary);
  final OutlineInputBorder _customOutlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
    borderSide: BorderSide(
      color: AppColorSwatche.primary,
    ),
  );
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? nameValidate(String? inp) {
    if (inp == null || inp == "") {
      return "Required *";
    } else if (inp.length != 10) {
      return "Enter a valid 10 digit number";
    }
    return null;
  }

  String? addrValidate(String? inp) {
    if (inp == null || inp == "") {
      return "Required *";
    } else if (inp.length > 120) {
      return "Address word limit cross (120 characters)";
    }
    return null;
  }

  String? phoneValidate(String? inp) {
    if (inp == null || inp == "") {
      return "Required *";
    } else if (inp.length != 10) {
      return "Enter a valid 10 digit number";
    }
    final number = num.tryParse(inp);
    if (number == null || number < 0) {
      return "Enter only digits";
    }
    return null;
  }

  String? pincodeValidate(String? inp) {
    if (inp == null || inp == "") {
      return "Required *";
    } else if (inp.length != 6) {
      return "Enter a valid 6 digit pincode";
    }
    final number = num.tryParse(inp);
    if (number == null || number < 0) {
      return "Enter only digits";
    }
    return null;
  }

  String? pwdValidate(String? inp) {
    if (inp == null || inp == "") {
      return "Required *";
    } else if (inp.length > 32 || inp.length < 8) {
      return "Enter a valid 8-32 length password";
    }
    if (_pwd != _confpwd) {
      return "Passwords do not match";
    }
    return null;
  }

  String? refValidate(String? inp) {
    if (inp == null || inp == "") {
      return null;
    }
    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    if (!validCharacters.hasMatch(inp)) {
      return 'Invalid referral Code';
    }
    return null;
  }

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
        body: SingleChildScrollView(
          child: Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            // height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(16.0),
            child: Center(
                child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  // Name Input
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      onChanged: (String? inp) {
                        _name = inp;
                      },
                      validator: nameValidate,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(64)
                      ],
                      style: TextStyle(fontSize: _textInputfontSize),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColorSwatche.primary,
                          ),
                          hintText: 'Your name',
                          labelText: 'Enter name',
                          labelStyle: _customTStyle,
                          border: _customOutlineBorder,
                          focusedBorder: _customOutlineBorder,
                          enabledBorder: _customOutlineBorder,
                          hintStyle: _customTStyle,
                          errorBorder: _customOutlineBorder,
                          focusedErrorBorder: _customOutlineBorder),
                    ),
                  ),
                  // Phone Input
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      validator: phoneValidate,
                      onChanged: (String? inp) {
                        this._phone = inp;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: TextStyle(fontSize: _textInputfontSize),
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.phone, color: AppColorSwatche.primary),
                        hintText: 'Your phone',
                        labelText: 'Enter phone',
                        labelStyle: _customTStyle,
                        focusedBorder: _customOutlineBorder,
                        border: _customOutlineBorder,
                        enabledBorder: _customOutlineBorder,
                        errorBorder: _customOutlineBorder,
                        focusedErrorBorder: _customOutlineBorder,
                        hintStyle: _customTStyle,
                      ),
                    ),
                  ),
                  // Address Input
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        onChanged: (String? inp) {
                          this._addr = inp;
                        },
                        validator: addrValidate,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(120),
                        ],
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
                          border: _customOutlineBorder,
                          enabledBorder: _customOutlineBorder,
                          errorBorder: _customOutlineBorder,
                          focusedErrorBorder: _customOutlineBorder,
                          hintStyle: _customTStyle,
                        ),
                      )),
                  // Pincode Input
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      onChanged: (String? inp) {
                        this._pin = inp;
                      },
                      validator: pincodeValidate,
                      style: TextStyle(fontSize: _textInputfontSize),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(6),
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
                        border: _customOutlineBorder,
                        enabledBorder: _customOutlineBorder,
                        errorBorder: _customOutlineBorder,
                        focusedErrorBorder: _customOutlineBorder,
                        hintStyle: _customTStyle,
                      ),
                    ),
                  ),
                  // Referral Input
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      onChanged: (String? inp) {
                        this._refcode = inp;
                      },
                      validator: refValidate,
                      inputFormatters: [LengthLimitingTextInputFormatter(32)],
                      style: TextStyle(fontSize: _textInputfontSize),
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.code, color: AppColorSwatche.primary),
                        hintText: 'REFERRALCODE',
                        labelText: 'Referral code (optional)',
                        labelStyle: _customTStyle,
                        focusedBorder: _customOutlineBorder,
                        border: _customOutlineBorder,
                        enabledBorder: _customOutlineBorder,
                        errorBorder: _customOutlineBorder,
                        focusedErrorBorder: _customOutlineBorder,
                        hintStyle: _customTStyle,
                      ),
                    ),
                  ),
                  // Password Input
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      onChanged: (String? inp) {
                        this._pwd = inp;
                      },
                      validator: pwdValidate,
                      inputFormatters: [LengthLimitingTextInputFormatter(8)],
                      style: TextStyle(fontSize: _textInputfontSize),
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.lock, color: AppColorSwatche.primary),
                        hintText: 'secret',
                        labelText: 'Password',
                        labelStyle: _customTStyle,
                        focusedBorder: _customOutlineBorder,
                        border: _customOutlineBorder,
                        enabledBorder: _customOutlineBorder,
                        errorBorder: _customOutlineBorder,
                        focusedErrorBorder: _customOutlineBorder,
                        hintStyle: _customTStyle,
                      ),
                    ),
                  ),
                  // Confirm Passwod Input
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      onChanged: (String? inp) {
                        this._confpwd = inp;
                      },
                      validator: pwdValidate,
                      inputFormatters: [LengthLimitingTextInputFormatter(8)],
                      style: TextStyle(fontSize: _textInputfontSize),
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.lock, color: AppColorSwatche.primary),
                        hintText: 'secret',
                        labelText: 'Confirm password',
                        labelStyle: _customTStyle,
                        focusedBorder: _customOutlineBorder,
                        border: _customOutlineBorder,
                        enabledBorder: _customOutlineBorder,
                        errorBorder: _customOutlineBorder,
                        focusedErrorBorder: _customOutlineBorder,
                        hintStyle: _customTStyle,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState != null &&
                          !_formkey.currentState!.validate()) {
                        return;
                      }
                      Map<String, dynamic> data = new Map();
                      data['active'] = true;
                      data['customerName'] = _name;
                      data['customerPhoneNumber'] = _phone;
                      data['customerPincode'] = _pin;
                      data['garageReferralCode'] = _refcode;
                      data['customerAddress'] = _addr;
                      data['password'] = _pwd;
                      bool response =
                          await CustomerAPIManager.addCustomer(data);
                      if (response) {
                        Navigator.pushNamed(context, '/cust_addvehicle');
                      } else {
                        AlertDialog errorAlert = AlertDialog(
                          title: Text(
                            'Error!',
                            style: textStyle('h5', AppColorSwatche.primary),
                          ),
                          content: Text('Some error occured try later!',
                              style: textStyle('p1', AppColorSwatche.black)),
                        );
                        showDialog(
                            context: context,
                            builder: (BuildContext buildContext) => errorAlert);
                      }
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
              ),
            )),
          ),
        ));
  }
}
