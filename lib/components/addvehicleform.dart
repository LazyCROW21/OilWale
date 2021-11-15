import 'package:flutter/material.dart';
import 'package:oilwale/models/vehicle.dart';
import 'package:oilwale/models/vehiclecompany.dart';
import 'package:oilwale/service/vehicle_api.dart';
import 'package:oilwale/theme/themedata.dart';

class AddVehicleForm extends StatefulWidget {
  @override
  _AddVehicleFormState createState() => _AddVehicleFormState();
}

class _AddVehicleFormState extends State<AddVehicleForm> {
  List<VehicleCompany> _company = [];
  List<Vehicle> _models = [];
  bool loadingVCList = true;
  bool loadingVMList = true;
  Text loadingDDM = Text(
    'Loading Options..',
    style: textStyle('p1', AppColorSwatche.black),
  );

  @override
  void initState() {
    super.initState();
    VehicleAPIManager.getAllVehicleCompanies().then((result) {
      setState(() {
        loadingVCList = false;
        _company = result;
      });
    });
  }

  void changeModelList(String vehicleCompanyId) {
    setState(() {
      loadingVMList = true;
    });
    VehicleAPIManager.getVehiclesByCompanyId(vehicleCompanyId).then((_result) {
      setState(() {
        _models = _result;
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
                              },
                              value: _company.length != 0
                                  ? _company[0].vehicleCompanyId
                                  : null,
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
                              },
                              value: _models.length != 0
                                  ? _models[0].vehicleId
                                  : null,
                              items: _models
                                  .map((e) => vehicleModelDDMB(e))
                                  .toList()),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          onChanged: (String inp) {},
                          // validator: null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.drive_eta,
                                  color: AppColorSwatche.primary),
                              hintText: 'AB-XX-CD-XXXX',
                              labelText: 'Enter vehicle reg. number',
                              labelStyle:
                                  TextStyle(color: AppColorSwatche.primary),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                borderSide: BorderSide(
                                  color: AppColorSwatche.primary,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                  borderSide: BorderSide(
                                      color: AppColorSwatche.primary)),
                              hintStyle:
                                  TextStyle(color: AppColorSwatche.primary)),
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        onChanged: (String inp) {},
                        // validator: null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.linear_scale,
                                color: AppColorSwatche.primary),
                            hintText: '102453',
                            labelText: 'Total KM travelled',
                            labelStyle:
                                TextStyle(color: AppColorSwatche.primary),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(
                                color: AppColorSwatche.primary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                borderSide:
                                    BorderSide(color: AppColorSwatche.primary)),
                            hintStyle:
                                TextStyle(color: AppColorSwatche.primary)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        onChanged: (String inp) {},
                        // validator: null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.timeline,
                                color: AppColorSwatche.primary),
                            hintText: '102453',
                            labelText: 'Daily KM travel',
                            labelStyle:
                                TextStyle(color: AppColorSwatche.primary),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(
                                color: AppColorSwatche.primary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                borderSide:
                                    BorderSide(color: AppColorSwatche.primary)),
                            hintStyle:
                                TextStyle(color: AppColorSwatche.primary)),
                      ),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                onPressed: () {
                  print("vehicle added");
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
