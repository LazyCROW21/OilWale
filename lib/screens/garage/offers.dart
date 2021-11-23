import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilwale/models/OffersCatalog.dart';
import 'package:oilwale/screens/garage/offerdetails.dart';
import 'package:oilwale/screens/garage/products.dart';
import 'package:oilwale/screens/garage/profile.dart';
import 'package:oilwale/models/Offers.dart';
import 'package:oilwale/service/offers_api.dart';
import 'package:oilwale/theme/themedata.dart';
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
  List<Offers> _offList = [];
  SpinKitRing loadingRing = SpinKitRing(
    color: AppColorSwatche.primary,
  );
  bool isSearching = true;

  @override
  void initState() {
    super.initState();
    OffersAPIManager.getAllActiveScheme().then((resp) {
      setState(() {
        isSearching = false;
        _offList = resp;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }
  Widget build(BuildContext context) {
    return showoffer ? OfferDetails() :

         SingleChildScrollView(
           child: isSearching
               ? loadingRing :
           ListView.builder(
               shrinkWrap: true,
               itemCount: _offList.length,
               itemBuilder: (context, index) {
                 return OffersWidget(
                   offers: _offList[index],
                 );
               }),
         );
  }
}
