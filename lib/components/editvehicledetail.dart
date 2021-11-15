import 'package:flutter/material.dart';
import 'package:oilwale/components/formelements.dart';
import 'package:oilwale/models/vehicle.dart';
import 'package:oilwale/models/vehiclecompany.dart';
import 'package:oilwale/service/vehicle_api.dart';
import 'package:oilwale/theme/themedata.dart';

class EditVehicleDetailBlock extends StatefulWidget {
  @override
  _EditVehicleDetailBlockState createState() => _EditVehicleDetailBlockState();
}

class _EditVehicleDetailBlockState extends State<EditVehicleDetailBlock> {
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
                    },
                    value: _company.length != 0
                        ? _company[0].vehicleCompanyId
                        : null,
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
                    },
                    value: _models.length != 0 ? _models[0].vehicleId : null,
                    items: _models.map((e) => vehicleModelDDMB(e)).toList()),
          ),
          TextFormField(
            obscureText: true,
            onChanged: (String inp) {
              // _pwd = inp;
            },
            // validator: pwdValidate,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.drive_eta,
                  color: Colors.deepOrange,
                ),
                hintText: "AB01CD2345",
                labelText: 'Enter vehicle reg. numer',
                labelStyle: TextStyle(color: Colors.deepOrange),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepOrange,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColorSwatche.primary)),
                hintStyle: TextStyle(color: AppColorSwatche.primary)),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            obscureText: true,
            onChanged: (String inp) {
              // _pwd = inp;
            },
            // validator: pwdValidate,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.linear_scale,
                  color: Colors.deepOrange,
                ),
                hintText: "102453",
                labelText: 'Enter KM travelled',
                labelStyle: TextStyle(color: Colors.deepOrange),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepOrange,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColorSwatche.primary)),
                hintStyle: TextStyle(color: AppColorSwatche.primary)),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            obscureText: true,
            onChanged: (String inp) {
              // _pwd = inp;
            },
            // validator: pwdValidate,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.drive_eta,
                  color: Colors.deepOrange,
                ),
                hintText: "102453",
                labelText: 'Daily KM travel',
                labelStyle: TextStyle(color: Colors.deepOrange),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepOrange,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColorSwatche.primary)),
                hintStyle: TextStyle(color: AppColorSwatche.primary)),
          )
        ],
      ),
    );
  }
}
