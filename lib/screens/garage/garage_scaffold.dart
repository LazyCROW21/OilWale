import 'package:flutter/material.dart';
import 'package:oilwale/screens/garage/offers.dart';
import 'package:oilwale/screens/garage/products.dart';
import 'package:oilwale/screens/garage/home_page.dart';
import 'package:oilwale/screens/garage/profile.dart';
import '../garage/globals.dart';
import 'cart.dart';

class GarageScaffold extends StatefulWidget {

  const GarageScaffold({Key? key}) : super(key: key);

  @override
  _GarageScaffoldState createState() => _GarageScaffoldState();
}

class _GarageScaffoldState extends State<GarageScaffold> {
  int _currentindex = 0;

  void gotoOffers() {
    setState(() {
      _currentindex = 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._children = [
      HomePage(
        gotoOffer: () {
          gotoOffers();
        },
      ),
      OffersPage(),
      ProductsPage(),
      Profile()
    ];
  }

  List<Widget> _children = [];
  final bool showcart = false;

  void onTapped(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final floatingbtn = [
      null,
      null,
      FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Container(
                padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text("$cartnum", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,))),
            Center(child: Icon(Icons.shopping_cart)),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepOrange,
      ),
      null
    ];
    final popupmenubutton = [
      null,
      null,
      null,
      PopupMenuButton(
          offset: const Offset(0.0, 50.0),
          icon: Icon(
            Icons.more_vert,
            color: Colors.deepOrange,
          ),
          color: Colors.grey[300],
          itemBuilder: (context) => [
            PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text("Purchase History"),
                  ],
                )),
            PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text("Settings"),
                  ],
                )),
            PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text("Logout")
                  ],
                ))
          ])
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,

        actions:
        _currentindex == 3?
        [
             PopupMenuButton(
                offset: const Offset(0.0, 50.0),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.deepOrange,
                ),
                color: Colors.grey[300],
                itemBuilder: (context) =>
                [
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text("Purchase History"),
                        ],
                      )),
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text("Settings"),
                        ],
                      )),
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text("Logout")
                        ],
                      ))
                ])
        ] :[],
        title: Text(
          "Oil Wale",
          style: TextStyle(color: Colors.deepOrange),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: _children[_currentindex],
      floatingActionButton: floatingbtn[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: "Offers"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
