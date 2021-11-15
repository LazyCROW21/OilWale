import 'package:flutter/material.dart';
import 'package:oilwale/models/productcatalog.dart';
import 'package:oilwale/widgets/CartWidget.dart';
import 'package:oilwale/widgets/ItemWidget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: new AppBar(
          leading: BackButton(
            color: Colors.deepOrange,
          ),

          title: Text(
            "Oil Wale",
            style: TextStyle(color: Colors.deepOrange),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body:
        Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Items Purchased :   16" ),

                  ],
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: ListView.builder(
                    itemCount: CatalogModel.products.length,
                    itemBuilder: (context, index) {
                      return CartWidget(
                        item: CatalogModel.products[index],
                      );
                    }),
              ),
            ),
          ],
        )
    );



  }
}
