import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oilmart/models/customer.dart';
import 'package:oilmart/service/customer_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class AuthManager {
  // return bool on successful login or false on error
  static Future<bool> login(String phone, String pwd, bool customer) async {
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
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('token', jsonMap['token']);
          preferences.setString('role', 'customer');
          Customer customerdetail =
              await CustomerAPIManager.getCustomerDetail(jsonMap['id']);
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

  // return bool on successful logout or false on error
  static Future<bool> logout(String phone, String pwd, bool customer) async {
    try {
      // String urlStr = base_url + "/authenticate";
      // if (customer) {
      // Map<String, String> loginData = {
      //   'id': phone,
      //   'password': pwd,
      //   'role': 'customer'
      // };
      // String dataString = jsonEncode(loginData);
      // var client = http.Client();
      // var url = Uri.parse(urlStr);
      // print(dataString);
      // var response = await client.post(url,
      //     body: dataString, headers: {'Content-Type': 'application/json'});
      // if (response.statusCode == 200) {
      //   var jsonString = response.body;
      //   Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      //   print(jsonMap);
      //   Customer customerdetail =
      //       await CustomerAPIManager.getCustomerDetail(jsonMap['id']);

      // } else {

      // }
      // } else {
      // return true;
      // }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }
}
