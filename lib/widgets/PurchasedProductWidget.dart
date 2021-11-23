import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:oilwale/models/Offers.dart';
import 'package:oilwale/models/product.dart';

class PurchasedProductWidget extends StatelessWidget {
  PurchasedProductWidget({Key? key,required this.offers}) : super(key: key);
  final Offers offers;
  late var message = "placed";
  late Color msgcolor = Colors.yellowAccent[400]!;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/purchased_product',arguments: offers);
      },
      child: Container(
          child: Card(
        elevation: 2.0,
        child: Stack(
          children: [
            Positioned(
                top: 5.0,
                right: 5.0,
                child: Text(
                  "14.09.2021",
                  style: TextStyle(fontSize: 12.0),
                )),
            Positioned(
              top: 35.0,
              right: 25.0,
              child: TextButton(onPressed: () {}, child: Text(message)),
            ),
            Container(
              height: 50.0,
              width: 50.0,
              margin: EdgeInsets.all(15.0),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.deepOrange,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Text(
                          "4 Products Purchased",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
