import 'package:flutter/material.dart';
import 'package:oilwale/models/Offers.dart';
import 'package:oilwale/models/OffersCatalog.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/models/productcatalog.dart';
import 'package:oilwale/widgets/ItemWidget.dart';

class ShowProductbought extends StatelessWidget {
  ShowProductbought({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Offers offers = ModalRoute
        .of(context)!
        .settings
        .arguments as Offers;
    return Scaffold(
      appBar: AppBar(
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
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        child: Card(
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                // Expanded(child: ListView.builder(itemBuilder: (context, index) {
                //                   ItemWidget(product: product);
                // }
                // ))
                // Column(
                //   children: [
                //     InkWell(
                //         onTap: () { Navigator.pushNamed(context, '');},
                //         child: Card(
                //           elevation: 2.0,
                //           child: Container(
                //               child: Row(
                //             children: [
                //               Container(
                //                 margin:
                //                     EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                //                 width: 40.0,
                //                 height: 60.0,
                //                 decoration: BoxDecoration(
                //                     image: DecorationImage(
                //                         image: NetworkImage(
                //                             "https://picsum.photos/200"),
                //                         fit: BoxFit.cover)),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.only(left: 6.0),
                //                 child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Text("Product No 40",
                //                           style: TextStyle(
                //                               fontWeight: FontWeight.bold)),
                //                       Text(
                //                         "Discount : 50% ",
                //                       )
                //                     ]),
                //               ),
                //             ],
                //           )),
                //         )),
                //     InkWell(
                //       onTap: () {},
                //       child: Card(
                //         elevation: 2.0,
                //         child: Container(
                //             child: Row(
                //           children: [
                //             Container(
                //               margin:
                //                   EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                //               width: 40.0,
                //               height: 60.0,
                //               decoration: BoxDecoration(
                //                   image: DecorationImage(
                //                       image: NetworkImage(
                //                           "https://picsum.photos/200"),
                //                       fit: BoxFit.cover)),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.only(left: 6.0),
                //               child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text("Product No 41s",
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold)),
                //                     Text("Discount : 50%")
                //                   ]),
                //             ),
                //           ],
                //         )),
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, '/garage_offers');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red[100]!.withOpacity(0.5),
                        ),
                        child: Text(
                          "Decline",
                          style: TextStyle(color: Colors.red),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, '/garage_offers');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green[100]!.withOpacity(0.5),
                        ),
                        child: Text(
                          "Accept",
                          style: TextStyle(color: Colors.green),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
