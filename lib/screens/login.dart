import 'package:flutter/material.dart';

enum Choice { Customer, Garage }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Choice? _choice = Choice.Customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Oilwale",
            style: TextStyle(color: Colors.deepOrange),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(36.0),
          child: Center(
              child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.deepOrange,
                        ),
                        hintText: '000-000-0000',
                        labelText: 'Enter phone',
                        labelStyle: TextStyle(color: Colors.deepOrange),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange)),
                        hintStyle: TextStyle(color: Colors.deepOrange)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.password,
                          color: Colors.deepOrange,
                        ),
                        hintText: "Secret",
                        labelText: 'Enter password',
                        labelStyle: TextStyle(color: Colors.deepOrange),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange)),
                        hintStyle: TextStyle(color: Colors.deepOrange)),
                  ),
                ),
                RadioListTile<Choice>(
                  title: const Text('Login as Customer'),
                  value: Choice.Customer,
                  groupValue: _choice,
                  onChanged: (Choice? value) {
                    setState(() {
                      _choice = value;
                    });
                  },
                ),
                RadioListTile<Choice>(
                  title: const Text('Login as Garage Dealer'),
                  value: Choice.Garage,
                  groupValue: _choice,
                  onChanged: (Choice? value) {
                    setState(() {
                      _choice = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_choice == Choice.Customer) {
                      Navigator.pushReplacementNamed(context, '/cust_home');
                    } else if (_choice == Choice.Garage) {
                      Navigator.pushReplacementNamed(context, '/garage_home');
                    }
                  },
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size.fromWidth(MediaQuery.of(context).size.width))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider()),
                      Text("or"),
                      Expanded(child: Divider())
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cust_createAccount');
                  },
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size.fromWidth(MediaQuery.of(context).size.width))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Create New Customer Account',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
