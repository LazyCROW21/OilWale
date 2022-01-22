import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:oilmart/components/product_tile.dart';
import 'package:oilmart/models/offer.dart';
import 'package:oilmart/theme/themedata.dart';

class CustomerOfferDetails extends StatefulWidget {
  @override
  _CustomerOfferDetailsState createState() => _CustomerOfferDetailsState();
}

class _CustomerOfferDetailsState extends State<CustomerOfferDetails> {
  bool isLoading = false;
  late Offer _offer;

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

  String getFormattedDT(String isoDate) {
    DateTime? convert = DateTime.tryParse(isoDate);
    if (convert == null) {
      return 'error';
    }
    final DateFormat formatter = DateFormat('dd MMM, y');
    return formatter.format(convert);
  }

  @override
  Widget build(BuildContext context) {
    _offer = ModalRoute.of(context)!.settings.arguments as Offer;
    // isLoading = false;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Offer",
            style: TextStyle(
                color: AppColorSwatche.white,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: isLoading
            ? Center(
                child: SpinKitRing(
                  color: AppColorSwatche.primary,
                ),
              )
            : SingleChildScrollView(
                // reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        _offer.schemeName,
                        textAlign: TextAlign.center,
                        style: textStyle('h4', AppColorSwatche.primary),
                      ),
                    ),
                    // Table of Dates
                    Table(
                      children: [
                        TableRow(children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Text('from: ',
                                textAlign: TextAlign.center,
                                style: textStyle('p1', AppColorSwatche.black)),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'to: ',
                              textAlign: TextAlign.center,
                              style: textStyle('p1', AppColorSwatche.black),
                            ),
                          )
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: AppColorSwatche.primaryAccent,
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(getFormattedDT(_offer.startedAt),
                                    textAlign: TextAlign.center,
                                    style:
                                        textStyle('p1', AppColorSwatche.white)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: AppColorSwatche.primaryAccent,
                              elevation: 4,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  getFormattedDT(_offer.endsAt),
                                  textAlign: TextAlign.center,
                                  style: textStyle('p1', AppColorSwatche.white),
                                ),
                              ),
                            ),
                          )
                        ])
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _offer.description,
                            style: textStyle('p1', AppColorSwatche.grey),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _offer.productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductTile(
                              product: _offer.productList[index],
                            );
                          }),
                    )
                  ],
                ),
              ));
  }
}
