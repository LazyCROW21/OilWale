import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:oilwale/models/garage.dart';
import 'package:oilwale/theme/themedata.dart';

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
  Widget build(BuildContext context) {
    garage = ModalRoute.of(context)!.settings.arguments as Garage;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.deepOrange),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            garage != null ? garage!.garageName : 'Not Found',
            style: textStyle('h4', AppColorSwatche.primary),
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
                  Row(
                    children: [
                      Icon(Icons.location_pin),
                      Text(
                        'Location',
                        style: textStyle('h5', AppColorSwatche.black),
                      )
                    ],
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
                          ? "Pincode: ${garage!.pincode}"
                          : 'Pincode: Not Found',
                      style: textStyle('p1', AppColorSwatche.grey),
                    ),
                  ),
                  Divider(
                    color: AppColorSwatche.primary,
                  ),
                  Row(
                    children: [
                      Icon(Icons.contact_page),
                      Text(
                        "Contact Details",
                        style: textStyle('h5', AppColorSwatche.black),
                      )
                    ],
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
                ]),
          ),
        ));
  }
}
