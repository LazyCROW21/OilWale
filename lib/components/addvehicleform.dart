import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oilwale/models/vehicle.dart';
import 'package:oilwale/models/vehiclecompany.dart';
import 'package:oilwale/service/customer_api.dart';
import 'package:oilwale/service/vehicle_api.dart';
import 'package:oilwale/theme/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddVehicleForm extends StatefulWidget {
  @override
  _AddVehicleFormState createState() => _AddVehicleFormState();
}

class _AddVehicleFormState extends State<AddVehicleForm> {
  List<VehicleCompany> _company = [];
  List<Vehicle> _models = [];
  Map<String, dynamic> newCustomerVehicle = {'active': true};
  bool loadingVCList = true;
  bool loadingVMList = true;
  Text loadingDDM = Text(
    'Loading Options..',
    style: textStyle('p1', AppColorSwatche.black),
  );

  // TextFormField Inputs
  String? vehicleCompanyIdInput;
  String? vehicleIdInput;
  String? totalKMTravelledInput;
  String? numberplateInput;
  String? dailyKMTravelInput;

  // TextFormField Error
  String? vehicleCompanyIdErrorText;
  String? vehicleIdErrorText;
  String? totalKMTravelledErrorText;
  String? numberplateErrorText;
  String? dailyKMTravelErrorText;

  // regex [A-Z]{2}[0-9]{1,2}[A-Z0-9]{1,2}[0-9]{4}
  RegExp numberPlateRegExp = new RegExp(
    r"^[A-Z]{2}[0-9]{1,2}[A-Z0-9]{1,2}[0-9]{4}$",
    caseSensitive: true,
    multiLine: false,
  );

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences preferences) {
      String? customerId = preferences.getString('customerId');
      if (customerId == null) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        return;
      }
      newCustomerVehicle['customerId'] = customerId;
    });
    VehicleAPIManager.getAllVehicleCompanies().then((result) {
      setState(() {
        loadingVCList = false;
        _company = result;
      });
      if (_company.length != 0) {
        vehicleCompanyIdInput = _company[0].vehicleCompanyId;
        changeModelList(_company[0].vehicleCompanyId);
      }
    });
  }

  void changeModelList(String vehicleCompanyId) {
    setState(() {
      loadingVMList = true;
    });
    VehicleAPIManager.getVehiclesByCompanyId(vehicleCompanyId).then((_result) {
      setState(() {
        _models = _result;
        if (_result.length != 0) {
          vehicleIdInput = _result[0].vehicleId;
        }
        loadingVMList = false;
      });
    });
  }

  DropdownMenuItem<String> vehicleCompanyDDMB(VehicleCompany vehicleCompany) {
    return DropdownMenuItem(
        value: vehicleCompany.vehicleCompanyId,
        child: Text(vehicleCompany.vehicleCompany,
            style: textStyle('p1', AppColorSwatche.black)));
  }

  DropdownMenuItem<String> vehicleModelDDMB(Vehicle vehicle) {
    return DropdownMenuItem(
        value: vehicle.vehicleId,
        child: Text(
          vehicle.vehicleModel,
          style: textStyle('p1', AppColorSwatche.black),
        ));
  }

  bool validateForm() {
    bool error = false;
    // check VehicleCompanyId
    if (vehicleCompanyIdInput == null || vehicleCompanyIdInput == '') {
      vehicleCompanyIdErrorText = '* Required';
      error = true;
    } else {
      vehicleCompanyIdErrorText = null;
    }

    // check VehicleId
    if (vehicleIdInput == null || vehicleIdInput == '') {
      vehicleIdErrorText = '* Required';
      error = true;
    } else {
      vehicleIdErrorText = null;
    }

    // check totalKMTravelledInput
    if (totalKMTravelledInput == null || totalKMTravelledInput == '') {
      totalKMTravelledErrorText = '* Required';
      error = true;
    } else if (int.tryParse(totalKMTravelledInput ?? '') == null) {
      totalKMTravelledErrorText = '* Invalid number';
      error = true;
    } else {
      totalKMTravelledErrorText = null;
    }

    // check numberplateInput
    if (numberplateInput == null || numberplateInput == '') {
      numberplateErrorText = '* Required';
      error = true;
    } else if (!numberPlateRegExp.hasMatch(numberplateInput ?? '')) {
      numberplateErrorText = '* Invalid format';
      error = true;
    } else {
      numberplateErrorText = null;
    }

    // check dailyKMTravelInput
    if (dailyKMTravelInput == null || dailyKMTravelInput == '') {
      dailyKMTravelErrorText = '* Required';
      error = true;
    } else if (int.tryParse(totalKMTravelledInput ?? '') == null) {
      dailyKMTravelErrorText = '* Invalid number';
      error = true;
    } else {
      dailyKMTravelErrorText = null;
    }
    return !error;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColorSwatche.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Add vehicle",
            style: textStyle('h4', AppColorSwatche.primary),
          ),
        ),
        body: Column(children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColorSwatche.primary),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: loadingVCList
                          ? Container(
                              padding: EdgeInsets.all(14.0),
                              width: MediaQuery.of(context).size.width - 44,
                              child: loadingDDM)
                          : DropdownButton<String>(
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              isExpanded: true,
                              underline: Container(
                                height: 2,
                                // color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? vehicleCompanyId) {
                                print('Selected: ' + (vehicleCompanyId ?? ''));
                                changeModelList(vehicleCompanyId ?? '');
                                setState(() {
                                  vehicleCompanyIdInput = vehicleCompanyId;
                                });
                              },
                              value: vehicleCompanyIdInput,
                              items: _company
                                  .map((e) => vehicleCompanyDDMB(e))
                                  .toList()),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: loadingVMList
                          ? Container(
                              padding: EdgeInsets.all(14.0),
                              width: MediaQuery.of(context).size.width - 44,
                              child: loadingDDM)
                          : DropdownButton<String>(
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              isExpanded: true,
                              underline: Container(
                                height: 2,
                                // color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? vehicleId) {
                                print('Selected: ' + (vehicleId ?? ''));
                                setState(() {
                                  vehicleIdInput = vehicleId;
                                });
                              },
                              value: vehicleIdInput,
                              items: _models
                                  .map((e) => vehicleModelDDMB(e))
                                  .toList()),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          onChanged: (String inp) {
                            numberplateInput = inp;
                          },
                          // validator: null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.drive_eta,
                                  color: AppColorSwatche.primary),
                              hintText: 'AB-XX-CD-XXXX',
                              labelText: 'Enter vehicle reg. number',
                              labelStyle:
                                  TextStyle(color: AppColorSwatche.primary),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              hintStyle:
                                  TextStyle(color: AppColorSwatche.primary),
                              errorText: numberplateErrorText),
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        onChanged: (String inp) {
                          totalKMTravelledInput = inp;
                        },
                        // validator: null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.linear_scale,
                                color: AppColorSwatche.primary),
                            hintText: '102453',
                            labelText: 'Total KM travelled',
                            labelStyle:
                                TextStyle(color: AppColorSwatche.primary),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            hintStyle:
                                TextStyle(color: AppColorSwatche.primary),
                            errorText: totalKMTravelledErrorText),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        onChanged: (String inp) {
                          dailyKMTravelInput = inp;
                        },
                        // validator: null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.timeline,
                                color: AppColorSwatche.primary),
                            hintText: '102453',
                            labelText: 'Daily KM travel',
                            labelStyle:
                                TextStyle(color: AppColorSwatche.primary),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            hintStyle:
                                TextStyle(color: AppColorSwatche.primary),
                            errorText: dailyKMTravelErrorText),
                      ),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                onPressed: () async {
                  bool validate = false;
                  setState(() {
                    validate = validateForm();
                  });
                  if (!validate) {
                    return;
                  }

                  newCustomerVehicle['vehicleCompanyId'] =
                      vehicleCompanyIdInput;
                  newCustomerVehicle['vehicleId'] = vehicleIdInput;
                  newCustomerVehicle['currentKM'] =
                      int.parse(totalKMTravelledInput ?? '0');
                  newCustomerVehicle['numberPlate'] = numberplateInput;
                  newCustomerVehicle['dailyKMTravelled'] =
                      int.parse(dailyKMTravelInput ?? '0');
                  bool result = await CustomerAPIManager.addCustomerVehicle(
                      newCustomerVehicle);
                  if (result) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "Vehicle Added",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  Fluttertoast.showToast(
                      msg: "Error in adding vehicle",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Submit",
                    style: textStyle('p1', Colors.white),
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                    fixedSize: MaterialStateProperty.all(
                        Size.fromWidth(MediaQuery.of(context).size.width)))),
          )
        ]));
  }
}
