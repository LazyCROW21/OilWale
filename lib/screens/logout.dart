import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilmart/theme/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Choice { Customer, Garage }

class LogoutScreen extends StatefulWidget {
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences preferences) {
      preferences.clear();
      Navigator.pushNamedAndRemoveUntil(context, '/login',
          (Route<dynamic> route) {
        return false;
      });
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitRing(color: AppColorSwatche.primary),
          SizedBox(
            height: 16,
          ),
          Text(
            'logging out..',
            style: textStyle('p1', AppColorSwatche.primary),
          )
        ],
      ),
    ));
  }
}
