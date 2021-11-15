import 'dart:convert';
import 'package:oilwale/models/vehicle.dart';
import 'package:oilwale/models/vehiclecompany.dart';
import 'package:http/http.dart' as http;

const String base_url = "https://oilwale.herokuapp.com/api";

class VehicleAPIManager {
  // return list of all Vehicle of specific Company on success or false on error
  static Future<List<Vehicle>> getVehiclesByCompanyId(String companyId) async {
    List<Vehicle> vehicles = [];
    try {
      var client = http.Client();
      String urlStr = base_url + "/vehicle/company/" + companyId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          vehicles.add(Vehicle.fromJSON(element));
          print(element);
        });
      }
      return vehicles;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return vehicles;
  }

  // return list of all Vehicle Companies on success or false on error
  static Future<dynamic> getAllVehicleCompanies() async {
    try {
      var client = http.Client();
      String urlStr = base_url + "/getVehicleCompany";
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        List<VehicleCompany> vehicleCompanies = [];
        var jsonString = response.body;
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          vehicleCompanies.add(VehicleCompany.fromJSON(element));
          print(element);
        });
        return vehicleCompanies;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }
}
