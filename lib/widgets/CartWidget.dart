import 'package:flutter/material.dart';
import '../models/product.dart';

class CartWidget extends StatefulWidget {
  final Product item;

  const CartWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  // var _message = "Add to cart";
  var count = 1;
  bool visibilitytag = true;

  void _changed() {
    setState(() {
        visibilitytag = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return visibilitytag ?  Padding(
        padding: EdgeInsets.only(left: 10.0, right: 15.0, top: 15.0),
        child: Stack(children: [
          Container(
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
                            widget.item.name,
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
                          widget.item.specification,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "volume : 4L",
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
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (count > 1) count--;
                                      });
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.deepOrange,
                                    ),
                                  )),
                                  Expanded(
                                    child: Center(
                                      child: Text("$count"),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            count++;
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.deepOrange,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.cancel_outlined),
                color: Colors.black,
                onPressed: () { _changed();},
              )),
        ])) : Container();
  }
}
