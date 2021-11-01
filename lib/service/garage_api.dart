import 'dart:convert';
import 'package:oilwale/models/garage.dart';
import 'package:http/http.dart' as http;

const String base_url = "https://oilwale.herokuapp.com/api";

class GarageAPIManager {
  // return list of garages on success or false on error
  static Future<dynamic> getGarages() async {
    try {
      var client = http.Client();
      String urlStr = base_url + "/getAllGarages";
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
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
}