import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/service/customer_api.dart';
import 'package:oilwale/theme/themedata.dart';

class VehicleCard extends StatelessWidget {
  final CustomerVehicle customerVehicle;

  const VehicleCard({Key? key, required this.customerVehicle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Dismissible(
        onDismissed: (DismissDirection direction) {
          // CustomerAPIManager.deleteCustomerVehicle(customerVehicle.id);
        },
        confirmDismiss: (DismissDirection direction) {
          AlertDialog errorAlert = AlertDialog(
            title: Text(
              'Confirm delete?',
              style: textStyle('h5', AppColorSwatche.primary),
            ),
            content: Text('Are you sure you want to delete this vehicle?',
                style: textStyle('p1', AppColorSwatche.black)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'No',
                    style: textStyle('h5', AppColorSwatche.grey),
                  )),
              TextButton(
                  onPressed: () async {
                    print("Deleting: ${customerVehicle.customerVehicleId}");
                    bool result =
                        await CustomerAPIManager.deleteCustomerVehicle(
                            customerVehicle.customerVehicleId);
                    if (!result) {
                      Navigator.pop(context, false);
                      Fluttertoast.showToast(
                          msg: "Error in deleting! try later",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    Navigator.pop(context, true);
                  },
                  child: Text('Yes', style: textStyle('h5', Colors.red)))
            ],
          );
          return showDialog(
              context: context,
              builder: (BuildContext buildContext) => errorAlert);
        },
        direction: DismissDirection.startToEnd,
        background: Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Icon(
                Icons.delete,
                color: AppColorSwatche.white,
              ),
            ),
          ),
        ),
        key: ValueKey(customerVehicle.customerVehicleId),
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pushNamed(context, "/cust_vehicle",
                arguments: customerVehicle);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: AppColorSwatche.primary, width: 4.0))),
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
      ),
    );
  }
}
