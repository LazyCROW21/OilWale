import 'dart:convert';
import 'package:http/http.dart' as http;

const String base_url = "https://oilwale.herokuapp.com/api";

class ServiceAPIManager {
  // return TotalNoOfService (int) or -1 on error
  static Future<int> getTotalNoOfService(String customerId) async {
    try {
      var client = http.Client();
      String urlStr = base_url + "/service/customer/" + customerId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        dynamic jsonMap = jsonDecode(jsonString);
        return jsonMap['Numberofservice'];
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return -1;
  }
}
