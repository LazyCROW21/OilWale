import 'package:flutter/material.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/theme/themedata.dart';

class VehicleCard extends StatefulWidget {
  final CustomerVehicle customerVehicle;

  const VehicleCard({Key? key, required this.customerVehicle})
      : super(key: key);

  @override
  _VehicleCardState createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  late CustomerVehicle cardVehicle;

  @override
  void initState() {
    super.initState();
    cardVehicle = widget.customerVehicle;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(color: AppColorSwatche.primary, width: 4.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                cardVehicle.model,
                style: textStyle('h5', Colors.black),
              ),
              Text(
                cardVehicle.numberPlate,
                style: textStyle('p1', Colors.black),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                  "KM Reading: ${cardVehicle.currentKM}, ${cardVehicle.kmperday} KM/day",
                  style: textStyle('p2', Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
