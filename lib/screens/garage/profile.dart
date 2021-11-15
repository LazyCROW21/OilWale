import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(
                      'https://thecinemaholic.com/wp-content/uploads/2021/03/0_iRU5IQ2KGkDyGzyw.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Divider(
                  height: 30.0,
                  thickness: 1.0,
                  color: Colors.orange,
                ),
              ),
              Center(
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "User ID:",
                        style:
                        TextStyle(color: Colors.grey[700], fontSize: 13.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "1234567",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
                child: Divider(
                  height: 30.0,
                  thickness: 1.0,
                  color: Colors.orange,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Garage Name",
                        style:
                            TextStyle(color: Colors.orangeAccent[700], fontSize: 10.0)),
                    Text(
                      "Sonu Ka garage",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(" Owner's Name",
                        style:
                            TextStyle(color: Colors.orangeAccent[700], fontSize: 10.0)),
                    Text(
                      "Sonu Paisewala ",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(" Numnber",
                        style:
                            TextStyle(color: Colors.orangeAccent[700], fontSize: 10.0)),
                    Text(
                      " 8781115157 ",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Alternate Numnber",
                        style:
                            TextStyle(color: Colors.orangeAccent[700], fontSize: 10.0)),
                    Text(
                      " 8781115157 ",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(" Address",
                        style:
                            TextStyle(color: Colors.orangeAccent[700], fontSize: 10.0)),
                    Text(
                      "21, Neelkamal Society Opp. Takshshila Society Galaxy Naroda Ahmedabad",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Area ",
                        style:
                            TextStyle(color: Colors.orangeAccent[700], fontSize: 10.0)),
                    Text(
                      "Naroda ",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(" PinCode",
                        style:
                            TextStyle(color: Colors.orangeAccent[700], fontSize: 10.0)),
                    Text(
                      "382330 ",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
