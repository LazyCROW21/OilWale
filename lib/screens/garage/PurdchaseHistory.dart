import 'package:flutter/material.dart';
import 'package:oilwale/models/offers.dart';
import 'package:oilwale/widgets/PurchasedProductWidget.dart';

class CatalogModel {
  static final List<Offers> offers = [
    Offers(
      // minqty: '',
        schemeId: '',
        targetGroup: '',
        endsAt: '13.09.21',
        startedAt: '14.09.21',
        description: 'Hi there love uh till the end adhfbhda iaiawef iuafiyuvnar viuahrfiuarwbja iuaauorfjaof iuaaorf',
        productIdList: [],
        // percentage: '',
        status: true,
        schemeName: '50% off on every product for 2 wheeler'),
    Offers(
      // minqty: '',
        targetGroup: '',
        schemeId: '',
        endsAt: '13.09.21',
        startedAt: '14.09.21',
        description: 'Hi there love uh till the end adhfbhda iaiawef iuafiyuvnar viuahrfiuarwbja iuaauorfjaof iuaaorf',
        productIdList: [],
        // percentage: '',
        status: true,
        schemeName: '50% off on every product for 2 wheeler'),
  ];
}

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({Key? key}) : super(key: key);

  @override
  _PurchaseHistoryState createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  late Offers offers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Oilwale",
            style: TextStyle(color: Colors.deepOrange),
          ),
          leading: BackButton(
            color: Colors.deepOrange,
          ),
        ),
        body: Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: CatalogModel.offers.length,
              itemBuilder: (context, index) {
                return PurchasedProductWidget(
                  offers: CatalogModel.offers[index],
                );
              }),
        ));
  }
}
