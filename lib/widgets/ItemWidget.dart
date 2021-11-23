import 'package:flutter/material.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/screens/garage/globals.dart';

class ItemWidget extends StatefulWidget {
  final Product product;

  ItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  var count = " Add to Cart ";

  Color added = Colors.deepOrange[200]!.withOpacity(.1);

  Color cartaddedtext = Colors.deepOrange;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { Navigator.pushNamed(context, '/cust_product',arguments: widget.product);},
      child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0, top: 15.0),
          child: Container(
            height: 140.0,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  width: 80.0,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/200"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 4.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: 175.0,
                        child: Text(
                          widget.product.specification,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                         "Grade :" + widget.product.grade,
                          style: TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100.0,
                            height: 35.0,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (count == "Added to Cart") {
                                      added =
                                          Colors.deepOrange[200]!.withOpacity(.3);
                                      count = "Add to Cart";
                                      cartaddedtext = Colors.deepOrange;
                                      cartnum--;
                                    } else {
                                      count = "Added to Cart";
                                      added = Colors.green;
                                      cartaddedtext = Colors.white;
                                      cartnum++;
                                    }
                                  });
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: added.withOpacity(0.7)),
                                child: Text(
                                  count,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: cartaddedtext, fontSize: 12.0),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}


