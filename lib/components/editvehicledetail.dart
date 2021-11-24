import 'package:flutter/material.dart';
import 'package:oilwale/models/customervehicle.dart';
import 'package:oilwale/models/vehicle.dart';
import 'package:oilwale/models/vehiclecompany.dart';
import 'package:oilwale/service/vehicle_api.dart';
import 'package:oilwale/theme/themedata.dart';

class EditVehicleDetailBlock extends StatefulWidget {
  final CustomerVehicle customerVehicle;
  final Function(CustomerVehicle) setUpdate;

  EditVehicleDetailBlock(this.customerVehicle, this.setUpdate);

  @override
  _EditVehicleDetailBlockState createState() =>
      _EditVehicleDetailBlockState(customerVehicle, setUpdate);
}

class _EditVehicleDetailBlockState extends State<EditVehicleDetailBlock> {
  CustomerVehicle customerVehicle;
  final Function(CustomerVehicle) parentCallBack;
  List<VehicleCompany> _company = [];
  List<Vehicle> _models = [];

  bool loadingVCList = true;
  bool loadingVMList = true;
  bool errorVCIdinput = false;
  bool errorVIdinput = false;
  bool errorNPinput = false;
  bool errorTKMinput = false;
  bool errorDKMinput = false;

  String? vehicleCompanyIdInput;
  String? vehicleCompanyIdErrorText;
  String? vehicleIdInput;
  String? vehicleIdErrorText;

  Text loadingDDM = Text(
    'Loading Options..',
    style: textStyle('p1', AppColorSwatche.black),
  );

  _EditVehicleDetailBlockState(this.customerVehicle, this.parentCallBack);

  // regex [A-Z]{2}[0-9]{1,2}[A-Z0-9]{1,2}[0-9]{4}
  RegExp numberPlateRegExp = new RegExp(
    r"^[A-Z]{2}[0-9]{1,2}[A-Z0-9]{1,2}[0-9]{4}$",
    caseSensitive: true,
    multiLine: false,
  );

  @override
  void initState() {
    super.initState();
    vehicleCompanyIdInput = customerVehicle.vehicleCompanyId;
    vehicleIdInput = customerVehicle.vehicleId;
    print(vehicleIdInput);
    VehicleAPIManager.getAllVehicleCompanies().then((result) {
      setState(() {
        loadingVCList = false;
        _company = result;
      });
      changeModelList(vehicleCompanyIdInput ?? '');
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
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Vehicle Details",
                style: textStyle('h4', AppColorSwatche.black),
              ),
            ),
            Divider(
              height: 24.0,
              color: AppColorSwatche.primary,
            ),
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
                        setState(() {
                          if (vehicleCompanyId == null) {
                            vehicleCompanyIdErrorText = '* Required';
                            errorVCIdinput = true;
                          } else {
                            vehicleCompanyIdErrorText = null;
                            errorVCIdinput = false;
                          }
                          vehicleCompanyIdInput = vehicleCompanyId;
                        });
                        customerVehicle.vehicleCompanyId =
                            vehicleCompanyId ?? '';
                        for (int i = 0; i < _company.length; i++) {
                          if (_company[i].vehicleCompanyId ==
                              vehicleCompanyId) {
                            customerVehicle.brand = _company[i].vehicleCompany;
                            break;
                          }
                        }
                        customerVehicle.vehicleId = '';
                        vehicleIdInput = null;
                        errorVIdinput = true;
                        setState(() {
                          vehicleIdErrorText = '* Required';
                        });
                        changeModelList(customerVehicle.vehicleCompanyId);
                      },
                      value: vehicleCompanyIdInput,
                      items:
                          _company.map((e) => vehicleCompanyDDMB(e)).toList()),
            ),
            // VehicleCompanyId / Company Error Text
            vehicleCompanyIdErrorText == null
                ? SizedBox(
                    height: 8,
                  )
                : Padding(
                    padding: EdgeInsets.fromLTRB(4, 4, 4, 8),
                    child: Text(
                      vehicleCompanyIdErrorText ?? '',
                      style: TextStyle(
                          color: Colors.red, fontStyle: FontStyle.italic),
                    ),
                  ),
            // Vehicle Model input
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
                        customerVehicle.vehicleId = vehicleId ?? '';
                        for (int i = 0; i < _models.length; i++) {
                          if (_models[i].vehicleId == vehicleId) {
                            customerVehicle.model = _models[i].vehicleModel;
                            break;
                          }
                        }
                        setState(() {
                          if (vehicleId == null) {
                            vehicleIdErrorText = '* Required';
                            errorVIdinput = true;
                          } else {
                            vehicleIdErrorText = null;
                            errorVIdinput = false;
                          }
                          vehicleIdInput = vehicleId;
                        });
                      },
                      value: vehicleIdInput,
                      items: _models.map((e) => vehicleModelDDMB(e)).toList()),
            ),
            // VehicleId / Model Error Text
            vehicleIdErrorText == null
                ? SizedBox(
                    height: 8,
                  )
                : Padding(
                    padding: EdgeInsets.fromLTRB(4, 4, 4, 8),
                    child: Text(
                      vehicleIdErrorText ?? '',
                      style: TextStyle(
                          color: Colors.red, fontStyle: FontStyle.italic),
                    ),
                  ),
            // Number Plate Input
            TextFormField(
              onChanged: (String inp) {
                customerVehicle.numberPlate = inp;
              },
              autovalidateMode: AutovalidateMode.always,
              validator: (String? inp) {
                // check numberplateInput
                if (inp == null || inp == '') {
                  errorNPinput = true;
                  return '* Required';
                } else if (!numberPlateRegExp.hasMatch(inp)) {
                  errorNPinput = true;
                  return '* Invalid format';
                }
                errorNPinput = false;
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
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            // Total KM Inpute
            TextFormField(
              onChanged: (String inp) {
                int totalKM = int.tryParse(inp) ?? customerVehicle.currentKM;
                customerVehicle.currentKM = totalKM;
              },
              autovalidateMode: AutovalidateMode.always,
              validator: (String? inp) {
                // check totalKMTravelledInput
                if (inp == null || inp == '') {
                  errorTKMinput = true;
                  return '* Required';
                } else if (int.tryParse(inp) == null) {
                  errorTKMinput = true;
                  return '* Invalid number';
                } else {
                  int? travel = int.tryParse(inp);
                  if (travel! > 999999) {
                    errorTKMinput = true;
                    return '* Unreal value (should be < 999999)';
                  }
                }
                errorTKMinput = false;
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
                  hintStyle: TextStyle(color: AppColorSwatche.primary)),
            ),
            SizedBox(
              height: 8.0,
            ),
            // Dialy KM Travel Input
            TextFormField(
              onChanged: (String inp) {
                int kmpd = int.tryParse(inp) ?? customerVehicle.kmperday;
                customerVehicle.kmperday = kmpd;
              },
              autovalidateMode: AutovalidateMode.always,
              validator: (String? inp) {
                // check dailyKMTravelInput
                if (inp == null || inp == '') {
                  errorDKMinput = true;
                  return '* Required';
                } else if (int.tryParse(inp) == null) {
                  errorDKMinput = true;
                  return '* Invalid number';
                } else {
                  int? dtravel = int.tryParse(inp);
                  if (dtravel! > 700) {
                    errorDKMinput = true;
                    return '* Unreal value (should be < 700)';
                  }
                }
                errorDKMinput = false;
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
              ),
            )
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
                if (errorNPinput ||
                    errorTKMinput ||
                    errorDKMinput ||
                    errorVCIdinput ||
                    errorVIdinput) {
                  return;
                }
                parentCallBack(customerVehicle);
              },
              child: Icon(
                Icons.save,
                color: AppColorSwatche.white,
              )),
        )
      ]),
    );
  }
}
