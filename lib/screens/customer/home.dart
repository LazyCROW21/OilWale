import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oilmart/screens/customer/home/offers.dart';
import 'package:oilmart/screens/customer/home/vehicles.dart';
import 'package:oilmart/screens/customer/home/profile.dart';
import 'package:oilmart/screens/customer/home/garages.dart';
import 'package:oilmart/screens/customer/home/products.dart';
import 'package:oilmart/theme/themedata.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int idx = 0;

  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void tabSelect(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorSwatche.white,
        centerTitle: true,
        title: Text(
          "OilMart",
          style: TextStyle(
              color: AppColorSwatche.primaryAccent,
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            // color: Colors.deepOrangeAccent,
            image: DecorationImage(
                image: AssetImage('assets/img/bgsq.png'),
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.21), BlendMode.dstATop))),
        child: PageView(
          controller: _pageController,
          onPageChanged: tabSelect,
          children: [
            VehiclesScreen(),
            OffersScreen(),
            ProductScreen(),
            GarageScreen(),
            ProfileScreen()
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: Colors.deepOrangeAccent,
        backgroundColor: Colors.white,
        items: const <Widget>[
          Icon(
            Icons.directions_car,
            color: Colors.white,
          ),
          Icon(
            Icons.loyalty,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag,
            color: Colors.white,
          ),
          Icon(
            Icons.garage_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.manage_accounts,
            color: Colors.white,
          )
        ],
        index: idx,
        onTap: (int index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
