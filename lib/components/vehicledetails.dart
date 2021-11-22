import 'package:flutter/material.dart';
import 'package:oilwale/components/editvehicledetail.dart';
import 'package:oilwale/components/product_tile.dart';
import 'package:oilwale/components/vehicledetailblock.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/theme/themedata.dart';

class VehicleDetails extends StatefulWidget {
  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  late CustomerVehicle customerVehicle;
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

  Widget toggleForm() {
    if (isEditing) {
      return _editVehicleDetailBlock;
    }
    return _vehicleDetailBlock;
  }

  IconData getEditButtonIcon() {
    if (isEditing) {
      return Icons.save;
    }
    return Icons.edit;
  }

  @override
  Widget build(BuildContext context) {
    customerVehicle =
        ModalRoute.of(context)!.settings.arguments as CustomerVehicle;
    _vehicleDetailBlock = VehicleDetailBlock(
        customerVehicle: CustomerVehicle(
            brand: customerVehicle.brand,
            customerVehicleId: customerVehicle.customerVehicleId,
            vehicleId: customerVehicle.vehicleId,
            vehicleCompanyId: customerVehicle.vehicleCompanyId,
            model: customerVehicle.model,
            numberPlate: customerVehicle.numberPlate,
            currentKM: customerVehicle.currentKM,
            kmperday: customerVehicle.kmperday));
    _editVehicleDetailBlock = EditVehicleDetailBlock(customerVehicle);
    // getRecommendedProducts(customerVehicle.vehicleId);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.deepOrange),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "My vehicle",
            style: TextStyle(color: AppColorSwatche.primary),
          ),
        ),
        body: SingleChildScrollView(
          // reverse: true,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Vehicle Details",
                            style: textStyle('h4', AppColorSwatche.black),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<CircleBorder>(
                                          CircleBorder(
                                              side: BorderSide(
                                                  color: AppColorSwatche
                                                      .primary)))),
                              onPressed: () {
                                setState(() {
                                  isEditing = !isEditing;
                                });
                              },
                              child: Icon(getEditButtonIcon()))
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      toggleForm(),
                    ],
                  ),
                ),
                Divider(
                  height: 24.0,
                ),
                Text(
                  "Next Service",
                  style: textStyle('h4', AppColorSwatche.black),
                ),
                Divider(),
                Text(
                  "Recommended Date: 24 Oct, 2021",
                  style: textStyle('p1', AppColorSwatche.black),
                ),
                Divider(),
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
                Divider(),
                Text("Recommended Products",
                    style: textStyle('h4', AppColorSwatche.black)),
                Container(
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
          ),
        ));
  }
}
