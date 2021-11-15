import 'package:flutter/material.dart';
import 'package:oilwale/screens/customer/home/vehicles.dart';
import 'package:oilwale/screens/customer/home/profile.dart';
import 'package:oilwale/screens/customer/home/garage.dart';
import 'package:oilwale/screens/customer/home/products.dart';

Widget getItem(idx) {
  switch (idx) {
    case 0:
      return VehiclesScreen();
    case 1:
      return GarageScreen();
    case 2:
      return ProductScreen();
    case 3:
      return ProfileScreen();
    default:
      return Container();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int idx = 0;
  void tabSelect(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Oilwale",
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
      body: Container(
        child: getItem(idx),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.garage_outlined),
            label: 'Find Garage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Find Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Profile',
          ),
        ],
        currentIndex: idx,
        onTap: tabSelect,
      ),
    );
  }
}
