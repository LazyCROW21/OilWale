import 'package:flutter/material.dart';
import 'screens/index.dart';
import 'components/addvehicleform.dart';

// import 'PAGES/home_page.dart';
import 'PAGES/garage_scaffold.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.deepOrange),
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
      '/cust_createAccount': (context) => CreateAccountScreen(),
      '/cust_addvehicle': (context) => AddVehicleForm(),
      '/garage_home': (context) => GarageScaffold(),
    },
  ));
}
