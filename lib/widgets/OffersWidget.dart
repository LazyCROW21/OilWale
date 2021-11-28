import 'package:flutter/material.dart';
import 'package:oilwale/models/offer.dart';

class OffersWidget extends StatelessWidget {
  const OffersWidget({Key? key, required this.offers}) : super(key: key);
  final Offer offers;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/offer_details', arguments: offers);
        },
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  margin: EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.local_offer_rounded,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offers.schemeName.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "offers.description halleleua",
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.deepOrange),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Last Date  :" + offers.endsAt.substring(0, 10),
                        style:
                            TextStyle(fontSize: 11.0, color: Colors.grey[800]),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
