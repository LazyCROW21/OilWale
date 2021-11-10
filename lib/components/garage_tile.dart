import 'package:flutter/material.dart';
import 'package:oilwale/models/garage.dart';

class GarageTile extends StatelessWidget {
  final Garage garage;
  final TextStyle heading =
      const TextStyle(fontSize: 20.0, color: Colors.black);
  final TextStyle para = const TextStyle(fontSize: 12.0, color: Colors.grey);

  const GarageTile({Key? key, required this.garage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pushNamed(context, "/cust_garage", arguments: garage);
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.white),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 12.0),
                // flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network('https://picsum.photos/200'),
                ),
                height: 80, width: 80,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${garage.garageName}",
                    style: heading,
                  ),
                  Text(
                    "Area: ${garage.pincode}",
                    style: para,
                  ),
                  Text(
                    "${garage.address}",
                    style: para,
                  )
                ],
              ),
            ],
          )),
    );
  }
}
