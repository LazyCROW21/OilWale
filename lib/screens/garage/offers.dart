import 'package:flutter/material.dart';
import 'package:oilwale/models/OffersCatalog.dart';
import 'package:oilwale/screens/garage/offerdetails.dart';
import 'package:oilwale/screens/garage/products.dart';
import 'package:oilwale/screens/garage/profile.dart';
import 'package:oilwale/models/Offers.dart';
import 'package:oilwale/widgets/OffersWidget.dart';

import 'home_page.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  OffersPageState createState() => OffersPageState();
}

class OffersPageState extends State<OffersPage> {
  bool showoffer = false;
  late Offers offers;


  Widget build(BuildContext context) {
    return showoffer ? OfferDetails() :

         Material(
           
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: CatalogModel.offers.length,
                        itemBuilder: (context, index) {
                          return OffersWidget(
                            offers: CatalogModel.offers[index],
                          );
                        }),
                  ],
                ),
              ),
            );
  }
}
