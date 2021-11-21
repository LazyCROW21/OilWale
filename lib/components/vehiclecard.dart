import 'package:flutter/material.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/theme/themedata.dart';

class VehicleCard extends StatelessWidget {
  final CustomerVehicle customerVehicle;

  const VehicleCard({Key? key, required this.customerVehicle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.pushNamed(context, "/cust_vehicle",
              arguments: customerVehicle);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  left:
                      BorderSide(color: AppColorSwatche.primary, width: 4.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  customerVehicle.model,
                  style: textStyle('h5', Colors.black),
                ),
                Text(
                  customerVehicle.numberPlate ?? "Not found",
                  style: textStyle('p1', Colors.black),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                    "KM Reading: ${customerVehicle.currentKM}, ${customerVehicle.kmperday} KM/day",
                    style: textStyle('p2', Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
