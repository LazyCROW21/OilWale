import 'package:flutter/material.dart';
import 'package:oilwale/models/offers.dart';
import 'package:oilwale/models/offersCatalog.dart';
import 'package:oilwale/widgets/PurchasedProductWidget.dart';

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
