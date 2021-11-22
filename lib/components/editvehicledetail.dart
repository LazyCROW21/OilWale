import 'package:flutter/material.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/models/vehicle.dart';
import 'package:oilwale/models/vehiclecompany.dart';
import 'package:oilwale/service/vehicle_api.dart';
import 'package:oilwale/theme/themedata.dart';

class EditVehicleDetailBlock extends StatefulWidget {
  final CustomerVehicle customerVehicle;

  EditVehicleDetailBlock(this.customerVehicle);

  @override
  _EditVehicleDetailBlockState createState() =>
      _EditVehicleDetailBlockState(customerVehicle);
}

class _EditVehicleDetailBlockState extends State<EditVehicleDetailBlock> {
  CustomerVehicle customerVehicle;
  List<VehicleCompany> _company = [];
  List<Vehicle> _models = [];
  bool loadingVCList = true;
  bool loadingVMList = true;
  String? vehicleCompanyIdInput;
  String? vehicleCompanyIdErrorText;
  String? vehicleIdInput;
  String? vehicleIdErrorText;
  String? dailyKMTravelInput;
  String? dailyKMTravelErrorText;
  String? numberplateInput;
  String? numberplateErrorText;
  String? totalKMTravelledInput;
  String? totalKMTravelledErrorText;
  Text loadingDDM = Text(
    'Loading Options..',
    style: textStyle('p1', AppColorSwatche.black),
  );

  _EditVehicleDetailBlockState(this.customerVehicle);

  // regex [A-Z]{2}[0-9]{1,2}[A-Z0-9]{1,2}[0-9]{4}
  RegExp numberPlateRegExp = new RegExp(
    r"^[A-Z]{2}[0-9]{1,2}[A-Z0-9]{1,2}[0-9]{4}$",
    caseSensitive: true,
    multiLine: false,
  );

  @override
  void initState() {
    super.initState();
    VehicleAPIManager.getAllVehicleCompanies().then((result) {
      setState(() {
        loadingVCList = false;
        _company = result;
        vehicleCompanyIdInput = customerVehicle.vehicleCompanyId;
      });
      changeModelList(vehicleCompanyIdInput ?? '');
      setState(() {
        vehicleIdInput = customerVehicle.vehicleId;
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
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
      int? travel = int.tryParse(totalKMTravelledInput ?? '');
      if (travel! > 999999) {
        totalKMTravelledErrorText = '* Unreal value (should be < 999999)';
        error = true;
      }
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
    } else if (int.tryParse(dailyKMTravelInput ?? '') == null) {
      dailyKMTravelErrorText = '* Invalid number';
      error = true;
    } else {
      dailyKMTravelErrorText = null;
      int? dtravel = int.tryParse(dailyKMTravelErrorText ?? '');
      if (dtravel! > 700) {
        dailyKMTravelErrorText = '* Unreal value (should be < 700)';
        error = true;
      }
    }
    return !error;
  }

  DropdownMenuItem<String> vehicleCompanyDDMB(VehicleCompany vehicleCompany) {
    return DropdownMenuItem(
        value: vehicleCompany.vehicleCompanyId,
        child: Text(
          vehicleCompany.vehicleCompany,
          style: textStyle('p1', AppColorSwatche.black),
        ));
  }

  DropdownMenuItem<String> vehicleModelDDMB(Vehicle vehicle) {
    return DropdownMenuItem(
        value: vehicle.vehicleId,
        child: Text(vehicle.vehicleModel,
            style: textStyle('p1', AppColorSwatche.black)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrange),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: loadingVCList
                ? Container(
                    padding: EdgeInsets.all(4.0),
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
                    items: _company.map((e) => vehicleCompanyDDMB(e)).toList()),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrange),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: loadingVMList
                ? Container(
                    padding: EdgeInsets.all(4.0),
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
                    items: _models.map((e) => vehicleModelDDMB(e)).toList()),
          ),
          TextFormField(
            onChanged: (String inp) {
              numberplateInput = inp;
            },
            autovalidateMode: AutovalidateMode.always,
            validator: (String? inp) {
              // check numberplateInput
              if (inp == null || inp == '') {
                return '* Required';
              } else if (!numberPlateRegExp.hasMatch(inp)) {
                return '* Invalid format';
              }
              return null;
            },
            initialValue: customerVehicle.numberPlate,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.drive_eta, color: AppColorSwatche.primary),
                hintText: 'AB-XX-CD-XXXX',
                labelText: 'Enter vehicle reg. number',
                labelStyle: TextStyle(color: AppColorSwatche.primary),
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
                hintStyle: TextStyle(color: AppColorSwatche.primary),
                errorText: numberplateErrorText),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            onChanged: (String inp) {
              totalKMTravelledInput = inp;
            },
            autovalidateMode: AutovalidateMode.always,
            validator: (String? inp) {
              // check totalKMTravelledInput
              if (inp == null || inp == '') {
                return '* Required';
              } else if (int.tryParse(inp) == null) {
                return '* Invalid number';
              } else {
                int? travel = int.tryParse(inp);
                if (travel! > 999999) {
                  return '* Unreal value (should be < 999999)';
                }
              }
              return null;
            },
            initialValue: '${customerVehicle.currentKM}',
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.linear_scale, color: AppColorSwatche.primary),
                hintText: '102453',
                labelText: 'Total KM travelled',
                labelStyle: TextStyle(color: AppColorSwatche.primary),
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
                hintStyle: TextStyle(color: AppColorSwatche.primary),
                errorText: totalKMTravelledErrorText),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            onChanged: (String inp) {
              dailyKMTravelInput = inp;
            },
            autovalidateMode: AutovalidateMode.always,
            validator: (String? inp) {
              // check dailyKMTravelInput
              if (inp == null || inp == '') {
                return '* Required';
              } else if (int.tryParse(inp) == null) {
                return '* Invalid number';
              } else {
                int? dtravel = int.tryParse(inp);
                if (dtravel! > 700) {
                  return '* Unreal value (should be < 700)';
                }
              }
              return null;
            },
            initialValue: '${customerVehicle.kmperday}',
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.timeline, color: AppColorSwatche.primary),
                hintText: '7',
                labelText: 'Daily KM travel',
                labelStyle: TextStyle(color: AppColorSwatche.primary),
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
                hintStyle: TextStyle(color: AppColorSwatche.primary),
                errorText: dailyKMTravelErrorText),
          )
        ],
      ),
    );
  }
}
