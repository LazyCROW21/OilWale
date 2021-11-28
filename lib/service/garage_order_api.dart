import 'dart:convert';
import 'package:oilwale/models/garage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class OrderAPIManager {
  static Future<List<Garage>> getGarageOrders() async {
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
}