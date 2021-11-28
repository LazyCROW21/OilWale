import 'dart:convert';
import 'package:oilwale/models/garage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class GarageAPIManager {
  // return list of garages on success or false on error
  static Future<List<Garage>> getAllGarages() async {
    List<Garage> garages = [];
    try {
      var client = http.Client();
      String urlStr = base_url + "/garage/active";
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          garages.add(Garage.fromJSON(element));
          print(element);
        });
      }
      return garages;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return garages;
  }

  // return the search result from all garage list
  static Future<List<Garage>> searchGarage(String inp) async {
    List<Garage> garages = [];
    try {
      var client = http.Client();
      String urlStr = base_url + "/garage/search/" + Uri.encodeComponent(inp);
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          garages.add(Garage.fromJSON(element));
          print(element);
        });
      }
      return garages;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return garages;
  }

  // return customer object on success or false on error
  static Future<Garage?> getGarageDetails(String garageId) async {
    try {
      var client = http.Client();
      String urlStr = base_url + "/garage/" + garageId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        Garage garage = Garage.fromJSON(jsonMap);
        SharedPreferences preferences = await SharedPreferences.getInstance();

        // store in preferences
        preferences.setString('garageId', jsonMap['garageId'] ?? "");
        preferences.setString('garageName', jsonMap['garageName'] ?? "");
        preferences.setString('address', jsonMap['address'] ?? "");
        preferences.setString('pincode', jsonMap['pincode'] ?? "");
        preferences.setString('name', jsonMap['name']?? "");
        preferences.setString('phoneNumber', jsonMap['phoneNumber']  ?? "");
        preferences.setString('alternateNumber', jsonMap['alternateNumber']  ?? "");
        preferences.setString('gstNumber', jsonMap['gstNumber']  ?? "--");
        preferences.setString('panCard', jsonMap['panCard']  ?? "--");
        preferences.setString('area', jsonMap['area'] ?? "");
        preferences.setString('referralCode', jsonMap['referralCode']  ?? "");
        preferences.setInt('totalScore', jsonMap['totalScore']  ?? 0);
        preferences.setInt('totalCustomer', jsonMap['totalCustomer']  ?? 0);

        return garage;
      } else {
        return null;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return null;
  }
}
