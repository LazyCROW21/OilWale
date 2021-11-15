import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        // color: Colors.deepOrange,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                // flex: 1,
                child:
                    Image.network(product.image ?? 'https://picsum.photos/200'),
                height: 80),
            Container(
                // flex: 3,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                          color: Colors.deepOrange[800], fontSize: 24.0),
                    ),
                    Row(
                      children: [
                        Text('Grade: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0)),
                        Text(product.grade,
                            style: TextStyle(
                                color: Colors.deepOrange[800], fontSize: 18.0)),
                      ],
                    ),
                    Text(product.specification ?? '',
                        style: TextStyle(color: Colors.black, fontSize: 18.0)),
                  ],
                )),
          ],
        ));
  }
}
