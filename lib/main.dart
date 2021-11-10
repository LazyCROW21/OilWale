import 'package:flutter/material.dart';
import 'package:oilwale/screens/customer/home/garagepage.dart';
import 'package:oilwale/screens/customer/home/productpage.dart';
import 'package:oilwale/components/vehicledetails.dart';
import 'package:oilwale/screens/customer/index.dart';
import 'package:oilwale/components/addvehicleform.dart';
import 'package:oilwale/screens/garage/garage_scaffold.dart';
import 'package:oilwale/theme/themedata.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        accentColor: AppColorSwatche.primary,
        accentColorBrightness: Brightness.light,
        iconTheme: IconThemeData(color: AppColorSwatche.primary),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
        radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.all(Colors.deepOrange)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepOrange))),
        backgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.deepOrange[200],
            selectedItemColor: Colors.deepOrange),
        appBarTheme: AppBarTheme(backgroundColor: Colors.white)),
    initialRoute: '/login',
    home: GarageScaffold(),
    routes: {
      // '/': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/cust_home': (context) => HomeScreen(),
      '/cust_vehicle': (context) => VehicleDetails(),
      '/cust_product': (context) => ProductPage(),
      '/cust_garage': (context) => GaragePage(),
      '/cust_createAccount': (context) => CreateAccountScreen(),
      '/cust_addvehicle': (context) => AddVehicleForm(),
      '/garage_home': (context) => GarageScaffold(),
    },
  ));
}
