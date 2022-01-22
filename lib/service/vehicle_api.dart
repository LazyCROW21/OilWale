import 'dart:convert';
import 'package:oilmart/models/vehicle.dart';
import 'package:oilmart/models/vehiclecompany.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class VehicleAPIManager {
  // return list of all Vehicle of specific Company on success or false on error
  static Future<List<Vehicle>> getVehiclesByCompanyId(String companyId) async {
    List<Vehicle> vehicles = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return vehicles;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr = base_url + "/vehicle/company/" + companyId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
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

  static Future<dynamic> getVehicle(String vehicleId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return null;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr = base_url + "/vehicle/" + vehicleId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        dynamic jsonMap = jsonDecode(jsonString);
        print(jsonMap['suggestedProductDetails']);
        return jsonMap;
      } else {
        return null;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return null;
  }

  // return list of all Vehicle Companies on success or false on error
  static Future<dynamic> getAllVehicleCompanies() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return false;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr = base_url + "/getVehicleCompany";
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
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

  // return list of vehicle that are recommended for the specified product
  static Future<List<Vehicle>> getRecommendedVehiclesByProductId(
      String productId) async {
    List<Vehicle> vehicles = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return vehicles;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr = base_url + "/vehicle/product/" + productId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
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
}
