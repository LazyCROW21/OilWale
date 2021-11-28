import 'dart:convert';
import 'package:oilwale/models/offer.dart';
import 'package:http/http.dart' as http;

const String base_url = "https://oilwale.herokuapp.com/api";

class OffersAPIManager {
  // return list of Offers on success or false on error
  static Future<dynamic> getAllActiveScheme() async {
    List<Offer> offers = [];
    try {
      var client = http.Client();
      String urlStr = base_url + "/scheme/active";
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          offers.add(Offer.fromJSON(element));
          print(element);
        });
      }
      return offers;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return offers;
  }

  // return List of Offers for target group customer on success or else empty List
  static Future<List<Offer>> getActiveCustomerSchemes() async {
    List<Offer> offers = [];
    try {
      var client = http.Client();
      String urlStr = base_url + "/scheme/active/customers";
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          offers.add(Offer.fromJSON(element));
          print(element);
        });
      }
      return offers;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return offers;
  }

  // return List of upcoming Offers for target group customer on success or else empty List
  static Future<List<Offer>> getUpComingCustomerSchemes() async {
    List<Offer> offers = [];
    try {
      var client = http.Client();
      String urlStr = base_url + "/scheme/upcoming/customers";
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          offers.add(Offer.fromJSON(element));
          print(element);
        });
      }
      return offers;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return offers;
  }
}
