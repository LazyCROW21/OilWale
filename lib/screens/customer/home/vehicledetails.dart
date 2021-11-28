import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:oilwale/components/editvehicledetail.dart';
import 'package:oilwale/components/product_tile.dart';
import 'package:oilwale/components/servicecard.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/models/service.dart';
import 'package:oilwale/service/customer_api.dart';
import 'package:oilwale/service/service_api.dart';
import 'package:oilwale/theme/themedata.dart';

class VehicleDetails extends StatefulWidget {
  final CustomerVehicle customerVehicle;
  VehicleDetails(this.customerVehicle);
  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  late CustomerVehicle customerVehicle;
  late CustomerVehicle backUpCustomerVehicle;
  late List<ServiceHistory> serviceHistory = [];
  DateTime? nextServiceDate = null;
  String? nextServiceDateStr = null;
  bool isEditing = false;

  @override
  void initState() {
    customerVehicle = widget.customerVehicle;
    ServiceAPIManager.getServiceHistory(customerVehicle.customerVehicleId)
        .then((_result) {
      setState(() {
        if (_result.length > 0) {
          nextServiceDate = DateTime.tryParse(_result[0].dateOfService);
          if (nextServiceDate != null) {
            // 3 months OR 1500 KM
            int cntDays = (1500 / customerVehicle.kmperday).round();
            nextServiceDate!.add(Duration(days: cntDays));
            DateFormat formatter = DateFormat('dd MMM, y');
            nextServiceDateStr = formatter.format(nextServiceDate);
          }
        }
        serviceHistory = _result;
      });
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void updateVehicle(CustomerVehicle updVehicle) {
    customerVehicle.vehicleId = updVehicle.vehicleId;
    customerVehicle.model = updVehicle.model;
    customerVehicle.brand = updVehicle.brand;
    customerVehicle.vehicleCompanyId = updVehicle.vehicleCompanyId;
    customerVehicle.currentKM = updVehicle.currentKM;
    customerVehicle.kmperday = updVehicle.kmperday;
    customerVehicle.numberPlate = updVehicle.numberPlate;
    setState(() {
      isEditing = false;
    });
    CustomerAPIManager.updateCustomerVehicle(customerVehicle).then((result) {
      if (result) {
        setState(() {});
        Fluttertoast.showToast(
            msg: "Details updated!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        setState(() {
          customerVehicle = backUpCustomerVehicle;
        });
        Fluttertoast.showToast(
            msg: "Error in updating! try later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void changeToEditForm() {
    backUpCustomerVehicle = new CustomerVehicle(
        brand: customerVehicle.brand,
        currentKM: customerVehicle.currentKM,
        customerVehicleId: customerVehicle.customerVehicleId,
        kmperday: customerVehicle.kmperday,
        model: customerVehicle.model,
        numberPlate: customerVehicle.numberPlate,
        vehicleCompanyId: customerVehicle.vehicleCompanyId,
        vehicleId: customerVehicle.vehicleId,
        customerId: customerVehicle.customerId);
    setState(() {
      isEditing = true;
    });
  }

  Widget vehicleDetailBlock() {
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
                setState(() {
                  isEditing = true;
                });
              },
              child: Icon(
                Icons.edit,
                color: AppColorSwatche.white,
              )),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(customerVehicle),
          ),
          title: Text(
            "My vehicle",
            style: TextStyle(
                color: AppColorSwatche.white,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          // reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 8.0,
                margin: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: isEditing
                      ? EditVehicleDetailBlock(customerVehicle, updateVehicle)
                      : vehicleDetailBlock(),
                ),
              ),
              // Next Service
              Card(
                elevation: 8.0,
                margin: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Next Service",
                          style: textStyle('h4', AppColorSwatche.black)),
                      Divider(),
                      Text(
                        "Recommended Date: $nextServiceDateStr",
                        style: textStyle('p1', AppColorSwatche.black),
                      ),
                    ],
                  ),
                ),
              ),
              // Last Service
              Card(
                elevation: 8.0,
                margin: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Service History",
                            style: textStyle('h4', AppColorSwatche.black)),
                      ]),
                ),
              ),
              // Service History
              Container(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: serviceHistory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ServiceCard(serviceHistory[index]);
                    }),
              ),
              // Recommended Vehicle
              Card(
                elevation: 8.0,
                margin: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Recommended Products",
                            style: textStyle('h4', AppColorSwatche.black)),
                      ]),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                // height: 512,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: customerVehicle.suggestedProducts == null
                        ? 0
                        : customerVehicle.suggestedProducts!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductTile(
                        product: Product.fromJSON(
                            customerVehicle.suggestedProducts![index]),
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  DateFormat(String s) {}
}
