import 'package:flutter/material.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/theme/themedata.dart';

class VehicleDetailBlock extends StatelessWidget {
  final CustomerVehicle customerVehicle;
  final Function parentCallback;

  VehicleDetailBlock(this.customerVehicle, this.parentCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Vehicle Details",
                style: textStyle('h4', AppColorSwatche.black),
              ),
            ),
            Divider(
              color: AppColorSwatche.primary,
            ),
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
              customerVehicle.numberPlate,
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
        Positioned(
          top: 0,
          right: 0,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColorSwatche.primary),
                  shape: MaterialStateProperty.all<CircleBorder>(CircleBorder(
                      side: BorderSide(color: AppColorSwatche.primary)))),
              onPressed: () {
                parentCallback();
              },
              child: Icon(
                Icons.edit,
                color: AppColorSwatche.white,
              )),
        ),
      ]),
    );
  }
}
