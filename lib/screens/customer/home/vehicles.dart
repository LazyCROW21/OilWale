import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences preferences) {
      String? customerId = preferences.getString('customerId');
      if (customerId == null) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        return;
      }
      CustomerAPIManager.getCustomerVehicles(customerId).then((result) {
        setState(() {
          customerVehicleList = result;
        });
      });
    });
  }

  Widget vehicleListLoader() {
    if (customerVehicleList == null) {
      return Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitRing(color: AppColorSwatche.primary),
              SizedBox(
                width: 8,
              ),
              Text(
                'Loading',
                style: textStyle('p1', AppColorSwatche.black),
              ),
            ],
          ),
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
    return VehicleCard(customerVehicle: customerVehicleList![index]);
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: () {
                  Navigator.pushNamed(context, '/cust_addvehicle');
                },
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "+ Add Vehicle",
                        style: textStyle('p1', Colors.white),
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
