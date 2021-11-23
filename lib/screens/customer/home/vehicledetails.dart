import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oilwale/components/editvehicledetail.dart';
import 'package:oilwale/components/product_tile.dart';
import 'package:oilwale/components/vehicledetailblock.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/service/customer_api.dart';
import 'package:oilwale/theme/themedata.dart';

class VehicleDetails extends StatefulWidget {
  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  late CustomerVehicle customerVehicle;
  late CustomerVehicle backUpCustomerVehicle;
  late VehicleDetailBlock _vehicleDetailBlock;
  late EditVehicleDetailBlock _editVehicleDetailBlock;
  bool isEditing = false;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void updateVehicle(CustomerVehicle updVehicle) {
    customerVehicle.currentKM = updVehicle.currentKM;
    customerVehicle.kmperday = updVehicle.kmperday;
    customerVehicle.numberPlate = updVehicle.numberPlate;
    CustomerAPIManager.updateCustomerVehicle(customerVehicle).then((result) {
      setState(() {
        isEditing = false;
      });
      if (result) {
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

  @override
  Widget build(BuildContext context) {
    customerVehicle =
        ModalRoute.of(context)!.settings.arguments as CustomerVehicle;
    _vehicleDetailBlock = VehicleDetailBlock(customerVehicle, changeToEditForm);
    _editVehicleDetailBlock =
        EditVehicleDetailBlock(customerVehicle, updateVehicle);
    // getRecommendedProducts(customerVehicle.vehicleId);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "My vehicle",
            style: TextStyle(color: AppColorSwatche.white),
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
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.deepOrange),
                  //     borderRadius: BorderRadius.circular(8.0)),
                  child:
                      isEditing ? _editVehicleDetailBlock : _vehicleDetailBlock,
                ),
              ),
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
                        "Recommended Date: 24 Oct, 2021",
                        style: textStyle('p1', AppColorSwatche.black),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 8.0,
                margin: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Last Serviced",
                        style: textStyle('h4', AppColorSwatche.black),
                      ),
                      Divider(),
                      Text(
                        "Date: 04 Oct, 2021",
                        style: textStyle('p1', AppColorSwatche.black),
                      ),
                      Text(
                        "Product(s):",
                        style: textStyle('p1', AppColorSwatche.black),
                      ),
                    ],
                  ),
                ),
              ),
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
                      // return ListTile(
                      //     leading: Icon(Icons.circle),
                      //     trailing: Icon(
                      //       Icons.info,
                      //       color: Colors.blue,
                      //     ),

                      //     title: Text(
                      //         "${customerVehicle.suggestedProducts![index]['productName']}",
                      //         style: textStyle('p1', AppColorSwatche.black)));
                    }),
              ),
            ],
          ),
        ));
  }
}
