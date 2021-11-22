import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
        return Container();
      case 2:
        return productScreen;
      case 3:
        return garageScreen;
      case 4:
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
          color: Colors.deepOrangeAccent,
          // image: DecorationImage(
          //     image: AssetImage('assets/img/bgsq.png'),
          //     colorFilter: ColorFilter.mode(
          //         Colors.deepOrangeAccent.withOpacity(0.4),
          //         BlendMode.dstATop))
        ),
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepOrangeAccent,
        items: const <Widget>[
          Icon(Icons.directions_car),
          Icon(Icons.loyalty),
          Icon(Icons.shopping_bag),
          Icon(Icons.garage_outlined),
          Icon(Icons.manage_accounts)
        ],
        index: idx,
        onTap: tabSelect,
      ),
    );
  }
}
