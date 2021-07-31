import 'package:flutter/material.dart';
import '../components/formelements.dart';

class CreateAccountScreen extends StatelessWidget {
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
          padding: EdgeInsets.all(48.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextInput(
                  hint: 'Your name',
                  label: 'Enter name',
                  icon: Icon(
                    Icons.person,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextInput(
                  hint: '000-000-0000',
                  label: 'Enter phone',
                  icon: Icon(
                    Icons.phone,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextArea(
                    icon: Icon(
                      Icons.location_pin,
                      color: Colors.deepOrange,
                    ),
                    lines: 4,
                    label: 'Enter address',
                    hint: 'xyz society, abc area ...',
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextInput(
                  hint: '000000',
                  label: 'PINCODE',
                  icon: Icon(
                    Icons.fiber_pin_outlined,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextInput(
                  hint: 'REFERRALCODE',
                  label: 'Referral code (optional)',
                  icon: Icon(
                    Icons.code,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: PasswordInput(),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addvehicle');
                },
                style: ButtonStyle(
                    // textStyle: MaterialStateProperty.all<TextStyle>(
                    //     TextStyle(fontSize: 20.0)),
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
