import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oilwale/models/customer.dart';
import 'package:oilwale/service/customer_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class AuthManager {
  // return customer object on success or false on error
  static Future<dynamic> login(String phone, String pwd, bool customer) async {
    try {
      String urlStr = base_url + "/authenticate";
      if (customer) {
        Map<String, String> loginData = {
          'id': phone,
          'password': pwd,
          'role': 'customer'
        };
        String dataString = jsonEncode(loginData);
        var client = http.Client();
        var url = Uri.parse(urlStr);
        print(dataString);
        var response = await client.post(url,
            body: dataString, headers: {'Content-Type': 'application/json'});
        if (response.statusCode == 200) {
          var jsonString = response.body;
          Map<String, dynamic> jsonMap = jsonDecode(jsonString);
          print(jsonMap);
          Customer customerdetail =
              await CustomerAPIManager.getCustomerDetail(jsonMap['id']);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('token', jsonMap['token']);
          print(customerdetail);
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }
}
