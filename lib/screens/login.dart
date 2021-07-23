import 'package:flutter/material.dart';
import '../components/formelements.dart';

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
        body: Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextInput(
              hint: '000-000-0000',
              label: 'Enter phone',
              icon: Icon(Icons.phone),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.password),
                hintText: "Secret",
                labelText: 'Enter password',
                border: OutlineInputBorder(),
              ),
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
              Navigator.pushReplacementNamed(context, '/home');
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
              Navigator.pushNamed(context, '/createAccount');
            },
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(MediaQuery.of(context).size.width))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          )
        ],
      )),
    ));
  }
}
