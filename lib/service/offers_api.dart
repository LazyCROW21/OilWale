import 'dart:convert';
import 'package:oilwale/models/Offers.dart';
import 'package:http/http.dart' as http;

const String base_url = "https://oilwale.herokuapp.com/api";

class OffersAPIManager {
  // return list of Offers on success or false on error
  static Future<dynamic> getAllActiveScheme() async {
    List<Offers> offers = [];
    try {
      var client = http.Client();
      String urlStr = base_url + "/scheme/active";
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          offers.add(Offers.fromJSON(element['scheme']));
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
