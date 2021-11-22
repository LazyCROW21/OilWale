import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oilwale/components/vehiclecard.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/service/customer_api.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehiclesScreen extends StatefulWidget {
  @override
  _VehiclesScreenState createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  List<CustomerVehicle>? customerVehicleList;
  String? customerId;

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences preferences) {
      customerId = preferences.getString('customerId');
      if (customerId == null) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        return;
      }
      CustomerAPIManager.getCustomerVehicles(customerId ?? '').then((result) {
        setState(() {
          customerVehicleList = result;
        });
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget vehicleListLoader() {
    if (customerVehicleList == null) {
      return Container(
        child: Center(
          child: SpinKitRing(color: AppColorSwatche.primary),
        ),
      );
    } else if (customerVehicleList!.length == 0) {
      return Container(
        child: Text(
          'No vehicles added! Try adding one by clicking add vehicle below',
          style: textStyle('p1', AppColorSwatche.black),
        ),
      );
    }
    return ListView.builder(
        itemCount: customerVehicleList?.length ?? 0,
        itemBuilder: vehicleItemBuilder);
  }

  Widget vehicleItemBuilder(context, index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Dismissible(
          onDismissed: (DismissDirection direction) async {
            bool result = await CustomerAPIManager.deleteCustomerVehicle(
                customerVehicleList![index].customerVehicleId);
            if (!result) {
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
            customerVehicleList!.removeAt(index);
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
                    onPressed: () {
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
            decoration: BoxDecoration(color: AppColorSwatche.white),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 16),
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Icon(
                  Icons.delete,
                  color: AppColorSwatche.white,
                ),
              ),
            ),
          ),
          key: ValueKey(customerVehicleList![index].customerVehicleId),
          child: VehicleCard(customerVehicle: customerVehicleList![index])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: vehicleListLoader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColorSwatche.primary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () async {
                  var result =
                      await Navigator.pushNamed(context, '/cust_addvehicle');
                  try {
                    if (result as bool) {
                      setState(() {
                        customerVehicleList = null;
                      });
                      CustomerAPIManager.getCustomerVehicles(customerId ?? '')
                          .then((result) {
                        setState(() {
                          customerVehicleList = result;
                        });
                      });
                    }
                  } catch (e, s) {
                    print("Exception $e");
                    print("StackTrace $s");
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "+ Add Vehicle",
                        style: textStyle('p1', AppColorSwatche.white),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
