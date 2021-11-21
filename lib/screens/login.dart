import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:oilwale/service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Choice { Customer, Garage }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Choice? _choice = Choice.Customer;
  String _phone = "", _pwd = "", _errorText = "";

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? phoneValidate(String? inp) {
    if (inp == null || inp == "") {
      return "Required *";
    } else if (inp.length != 10) {
      return "Enter a valid 10 digit number";
    }
    return null;
  }

  String? pwdValidate(String? inp) {
    if (inp == null || inp == "") {
      return "Required *";
    } else if (inp.length > 32 || inp.length < 8) {
      return "Enter a valid 8-32 length password";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences preferences) {
      if (preferences.getString('token') != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/cust_home',
            (Route<dynamic> route) {
          return false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   systemOverlayStyle: SystemUiOverlayStyle(
        //       systemNavigationBarColor: AppColorSwatche.white,
        //       statusBarColor: AppColorSwatche.white),
        // ),
        body: Container(
      padding: EdgeInsets.all(36.0),
      child: Center(
          child: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/img/bgsq.png'),
            ),
            Form(
                key: _formkey,
                child: Column(children: [
                  TextFormField(
                    onChanged: (String inp) {
                      _phone = inp;
                    },
                    validator: phoneValidate,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.deepOrange,
                        ),
                        hintText: '000-000-0000',
                        labelText: 'Enter phone',
                        labelStyle: TextStyle(color: AppColorSwatche.primary),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColorSwatche.primary,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColorSwatche.primary)),
                        hintStyle: TextStyle(color: AppColorSwatche.primary)),
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (String inp) {
                      _pwd = inp;
                    },
                    validator: pwdValidate,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.deepOrange,
                        ),
                        hintText: "Secret",
                        labelText: 'Enter password',
                        labelStyle: TextStyle(color: Colors.deepOrange),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColorSwatche.primary)),
                        hintStyle: TextStyle(color: AppColorSwatche.primary)),
                  ),
                  SizedBox(
                    height: 36,
                    child: RadioListTile<Choice>(
                      title: const Text('Login as Customer'),
                      value: Choice.Customer,
                      groupValue: _choice,
                      onChanged: (Choice? value) {
                        setState(() {
                          _choice = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 36,
                    child: RadioListTile<Choice>(
                      title: const Text('Login as Garage Dealer'),
                      value: Choice.Garage,
                      groupValue: _choice,
                      onChanged: (Choice? value) {
                        setState(() {
                          _choice = value;
                        });
                      },
                    ),
                  ),
                ])),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
              child: Text(
                _errorText,
                style: textStyle('p1', Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formkey.currentState != null &&
                    !_formkey.currentState!.validate()) {
                  return;
                }
                if (_choice == Choice.Customer) {
                  if (await AuthManager.login(_phone, _pwd, true)) {
                    Navigator.pushNamedAndRemoveUntil(context, '/cust_home',
                        (Route<dynamic> route) {
                      return false;
                    });
                  } else {
                    setState(() {
                      _errorText = "Invalid credentials";
                    });
                  }
                } else if (_choice == Choice.Garage) {
                  if (await AuthManager.login(_phone, _pwd, false)) {
                    Navigator.pushReplacementNamed(context, '/garage_home');
                  } else {
                    setState(() {
                      _errorText = "Invalid credentials";
                    });
                  }
                }
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                  fixedSize: MaterialStateProperty.all(
                      Size.fromWidth(MediaQuery.of(context).size.width))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Login',
                  style: textStyle('p1', Colors.white),
                ),
              ),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cust_createAccount');
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                  fixedSize: MaterialStateProperty.all(
                      Size.fromWidth(MediaQuery.of(context).size.width))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Create New Customer Account',
                  style: textStyle('p1', Colors.white),
                ),
              ),
            )
          ],
        ),
      )),
    ));
  }
}
