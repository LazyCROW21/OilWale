import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oilwale/models/offers.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:oilwale/components/herodialogroute.dart';

class _OfferProductTile extends StatelessWidget {
  final Product product;
  _OfferProductTile(this.product);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/cust_product', arguments: product);
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/200',
                        height: 80,
                        width: 80,
                      )),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle('h4', AppColorSwatche.primary),
                          ),
                          Row(
                            children: [
                              Text('Grade: ',
                                  style:
                                      textStyle('h5', AppColorSwatche.black)),
                              Text(product.grade,
                                  style:
                                      textStyle('h5', AppColorSwatche.primary)),
                            ],
                          ),
                          Text(product.specification,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle('p1', Colors.black)),
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final Offer offer;
  final String status;

  const OfferCard(this.offer, this.status, {Key? key}) : super(key: key);

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
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/cust_offer', arguments: offer);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                offer.schemeName,
                textAlign: TextAlign.center,
                style: textStyle('h5', AppColorSwatche.primary),
              ),
              SizedBox(
                height: 4,
              ),
              status == 'upcoming'
                  ? Text(
                      'Offer starts at: ${getFormattedDT(offer.startedAt)}',
                      textAlign: TextAlign.start,
                      style: textStyle('p2', Colors.lightBlue),
                    )
                  : Text(
                      'Offer ends at: ${getFormattedDT(offer.endsAt)}',
                      textAlign: TextAlign.end,
                      style: textStyle('p2', Colors.lightBlue),
                    ),
              SizedBox(
                height: 8,
              ),
              Text(
                offer.description,
                textAlign: TextAlign.justify,
                style: textStyle('p1', AppColorSwatche.black),
              ),
              GestureDetector(
                onTap: () {
                  print("Pressing !");
                  Navigator.of(context).push(
                    HeroDialogRoute(
                      builder: (context) => Center(
                        child: Hero(
                          tag: ValueKey(offer.schemeId),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            padding: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height * 0.6,
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(12)),
                            child: ListView.builder(
                              itemCount: offer.productList.length,
                              itemBuilder: (context, index) {
                                return _OfferProductTile(
                                    offer.productList[index]);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: ValueKey(offer.schemeId),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: AppColorSwatche.primary),
                    // color: AppColorSwatche.primary,
                    child: Text(
                      'PRODUCT LIST',
                      textAlign: TextAlign.center,
                      style: textStyle('p1', AppColorSwatche.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
