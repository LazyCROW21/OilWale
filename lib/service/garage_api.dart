import 'dart:convert';
import 'package:oilwale/models/garage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class GarageAPIManager {
  // return list of garages on success or false on error
  static Future<dynamic> getAllGarages() async {
    try {
      var client = http.Client();
      String urlStr = base_url + "/garage/active";
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        List jsonMap = jsonDecode(jsonString);
        List<Garage> garages = [];
        jsonMap.forEach((element) {
          garages.add(Garage.fromJSON(element));
          print(element);
        });
        return garages;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }

  // return the search result from all garage list
  static Future<dynamic> searchGarage(String inp) async {
    try {
      var client = http.Client();
      String urlStr = base_url + "/garage/search/" + Uri.encodeComponent(inp);
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        List jsonMap = jsonDecode(jsonString);
        List<Garage> garages = [];
        jsonMap.forEach((element) {
          garages.add(Garage.fromJSON(element));
          print(element);
        });
        return garages;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }

  // return customer object on success or false on error
  static Future<dynamic> getGarageForLogin(String garageId) async {
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
        try {
          preferences.setString('garageId', jsonMap['garageId']);
          preferences.setString('garageName', jsonMap['garageName']);
          preferences.setString('address', jsonMap['address']);
          preferences.setString('pincode', jsonMap['pincode']);
          preferences.setString('name', jsonMap['name']);
          preferences.setString('phoneNumber', jsonMap['phoneNumber']);
          preferences.setString('alternateNumber', jsonMap['alternateeNumber']);
          preferences.setString('gstNumber', jsonMap['gstNumber']);
          preferences.setString('panCard', jsonMap['panCard']);
          preferences.setString('area', jsonMap['area']);
          preferences.setString('referralCode', jsonMap['referralCode']);
          preferences.setInt('totalScore', jsonMap['totalScore']);
          preferences.setInt('totalCustomer', jsonMap['totalCustomer']);
        } on Exception catch (exception) {
          print(exception);
          print(
              "There is some issue on the server . Please try after some time ");
        }
        return garage;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }

  // return customer object on success or false on error
  static Future<dynamic> getGarageById(String garageId) async {
    try {
      var client = http.Client();
      String urlStr = base_url + "/garage/" + garageId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        return jsonMap;
      }
      return null;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return null;
  }
}
