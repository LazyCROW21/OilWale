import 'package:flutter/material.dart';
import 'package:oilwale/components/vehiclecard.dart';

class VehiclesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VehicleCard(),
          VehicleCard(),
          VehicleCard(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cust_addvehicle');
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 24),
                    ),
                  )),
            ),
          )
        ],
      )),
    );
  }
}
