import 'package:flutter/material.dart';
import 'package:oilwale/screens/customer/home/vehicles.dart';
import 'package:oilwale/screens/customer/home/profile.dart';
import 'package:oilwale/screens/customer/home/garage.dart';
import 'package:oilwale/screens/customer/home/products.dart';
import 'package:oilwale/theme/themedata.dart';

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

  VehiclesScreen vehiclesScreen = VehiclesScreen();
  GarageScreen garageScreen = GarageScreen();
  ProductScreen productScreen = ProductScreen();
  ProfileScreen profileScreen = ProfileScreen();
  // @override
  // void initState() {
  //   super.initState();
  // }
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget getItem(idx) {
    switch (idx) {
      case 0:
        return vehiclesScreen;
      case 1:
        return garageScreen;
      case 2:
        return productScreen;
      case 3:
        return profileScreen;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Oilwale",
          style: TextStyle(color: AppColorSwatche.primary),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/bgsq.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop))),
        child: AnimatedSwitcher(
            reverseDuration: Duration.zero,
            duration: Duration(milliseconds: 500),
            child: getItem(idx),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                key: ValueKey(idx),
                position: Tween<Offset>(begin: Offset(2, 0), end: Offset.zero)
                    .animate(animation),
                child: child,
              );
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'My vehicles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.garage_outlined),
            label: 'Find Garage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
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
