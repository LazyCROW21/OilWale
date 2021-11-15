import 'package:flutter/material.dart';
import 'package:oilwale/components/oilwale_theme.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                  child: Container(
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 72,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(36.0)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: deepOrangeTS(fontSize: 12),
                    ),
                    Text(
                      "XYZ Kumar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            "Phone",
            style: deepOrangeTS(fontSize: 12),
          ),
          Text(
            "1230456789",
            style: TextStyle(fontSize: 18),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            "Address",
            style: deepOrangeTS(fontSize: 12),
          ),
          Text(
            "XYZ city, asd qwadsd",
            style: TextStyle(fontSize: 18),
          ),
          Divider(),
          SizedBox(height: 10),
          Text(
            "Total number of time oil serviced",
            style: deepOrangeTS(fontSize: 12),
          ),
          Text(
            "12",
            style: TextStyle(fontSize: 18),
          ),
          Divider(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Log out",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
