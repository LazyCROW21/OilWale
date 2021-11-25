import 'package:flutter/material.dart';

class ShowProductbought extends StatelessWidget {
  ShowProductbought({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final Offers offers = ModalRoute.of(context)!.settings.arguments as Offers;
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
