import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilwale/screens/garage/offerdetails.dart';
import 'package:oilwale/models/offers.dart';
import 'package:oilwale/service/offer_api.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:oilwale/widgets/OffersWidget.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  OffersPageState createState() => OffersPageState();
}

class OffersPageState extends State<OffersPage> {
  bool showoffer = false;
  late Offer offers;
  List<Offer> _offList = [];
  SpinKitRing loadingRing = SpinKitRing(
    color: AppColorSwatche.primary,
  );

  @override
  void initState() {
    super.initState();
    OffersAPIManager.getAllActiveScheme().then((resp) {
      setState(() {
        _offList = resp;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Widget build(BuildContext context) {
    return showoffer
        ? OfferDetails()
        : SingleChildScrollView(
            child: ListView.builder(
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
