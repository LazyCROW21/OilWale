import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oilmart/screens/customer/createaccount.dart';
import 'package:oilmart/screens/customer/home.dart';
import 'package:oilmart/screens/customer/home/garagepage.dart';
import 'package:oilmart/screens/customer/home/offerdetails.dart';
import 'package:oilmart/screens/customer/home/productpage.dart';
import 'package:oilmart/components/addvehicleform.dart';
import 'package:oilmart/screens/login.dart';
import 'package:oilmart/screens/logout.dart';
import 'package:oilmart/theme/themedata.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: AppColorSwatche.white,
      statusBarColor: Colors.transparent));
  runApp(MaterialApp(
    theme: ThemeData(
      splashColor: AppColorSwatche.primary,
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: AppColorSwatche.primary,
            secondary: AppColorSwatche.primaryAccent,
            brightness: Brightness.light,
          ),
      // accentColor: AppColorSwatche.primary,
      highlightColor: AppColorSwatche.primary,
    ),
    initialRoute: '/login',
    home: LoginScreen(),
    routes: {
      '/login': (context) => LoginScreen(),
      '/logout': (context) => LogoutScreen(),
      '/cust_home': (context) => HomeScreen(),
      // '/cust_vehicle': (context) => VehicleDetails(),
      '/cust_offer': (context) => CustomerOfferDetails(),
      '/cust_product': (context) => ProductPage(),
      '/cust_garage': (context) => GaragePage(),
      '/cust_createAccount': (context) => CreateAccountScreen(),
      '/cust_addvehicle': (context) => AddVehicleForm(),
    },
  ));
}
