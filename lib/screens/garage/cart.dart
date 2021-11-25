import 'package:flutter/material.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/service/product_api.dart';
import 'package:oilwale/widgets/CartWidget.dart';

import 'globals.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  List<Product> _pList = [];

  void initState() {
    super.initState();
    ProductAPIManager.getAllProducts().then((resp) {
      setState(() {
        _pList = resp;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

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
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Items Purchased :  $cartnum"),
                  ],
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: ListView.builder(
                    itemCount: _pList.length,
                    itemBuilder: (context, index) {
                      return CartWidget(
                        item: _pList[index],
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
