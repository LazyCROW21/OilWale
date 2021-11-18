import 'package:flutter/material.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/theme/themedata.dart';

class VehicleDetailBlock extends StatelessWidget {
  final CustomerVehicle customerVehicle;

  VehicleDetailBlock({required this.customerVehicle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Brand",
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerVehicle.brand,
            style: textStyle('p1', AppColorSwatche.black),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "Model",
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerVehicle.model,
            style: textStyle('p1', AppColorSwatche.black),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "Number Plate",
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerVehicle.numberPlate ?? "Not Available",
            style: textStyle('p1', AppColorSwatche.black),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "KM per day",
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerVehicle.kmperday.toString(),
            style: textStyle('p1', AppColorSwatche.black),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "Total Travelled Distance",
            style: textStyle('p2', AppColorSwatche.primary),
          ),
          Text(
            customerVehicle.currentKM.toString(),
            style: textStyle('p1', AppColorSwatche.black),
          ),
        ],
      ),
    );
  }
}