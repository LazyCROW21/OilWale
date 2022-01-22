import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:oilmart/models/garage.dart';
import 'package:oilmart/theme/themedata.dart';

class GaragePage extends StatefulWidget {
  @override
  _GaragePageState createState() => _GaragePageState();
}

class _GaragePageState extends State<GaragePage> {
  Garage? garage;

  final List<String> imageURLList = [
    'https://picsum.photos/200',
    'https://picsum.photos/200',
    'https://picsum.photos/200',
    'https://picsum.photos/200'
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   args = ModalRoute.of(context)!.settings.arguments as String;
  // }
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    garage = ModalRoute.of(context)!.settings.arguments as Garage;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColorSwatche.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Garage',
            style: TextStyle(
                color: AppColorSwatche.white,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      child: Hero(
                    tag: ValueKey(garage!.garageId),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height / 2.4,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false),
                      items: imageURLList
                          .map((e) => ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Image.network(
                                        e,
                                        height: 600,
                                        width: 600,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      garage != null ? garage!.garageName : 'Not Found',
                      textAlign: TextAlign.center,
                      style: textStyle('h4', AppColorSwatche.black),
                    ),
                  ),
                  Divider(
                    color: AppColorSwatche.primary,
                  ),
                  Card(
                    elevation: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_pin),
                              Text(
                                'Location',
                                style: textStyle('h5', AppColorSwatche.black),
                              )
                            ],
                          ),
                          Divider(
                            color: AppColorSwatche.primary,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              garage != null ? garage!.address : 'Not Found',
                              style: textStyle('p1', AppColorSwatche.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              garage != null
                                  ? "PIN Code: ${garage!.pincode}"
                                  : 'PIN Code: Not Found',
                              style: textStyle('p1', AppColorSwatche.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Contact Details
                  Card(
                    elevation: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.contact_page),
                              Text(
                                "Contact Details",
                                style: textStyle('h5', AppColorSwatche.black),
                              )
                            ],
                          ),
                          Divider(
                            color: AppColorSwatche.primary,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              garage != null
                                  ? "Owner: ${garage!.ownerName}"
                                  : 'Owner: Not Found',
                              style: textStyle('p1', AppColorSwatche.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              garage != null
                                  ? "Phone: ${garage!.phoneNumber}"
                                  : 'Phone: Not Found',
                              style: textStyle('p1', AppColorSwatche.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              garage != null
                                  ? "Alt. Phone: ${garage!.alternateNumber}"
                                  : 'Alt. Phone: Not Found',
                              style: textStyle('p1', AppColorSwatche.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
