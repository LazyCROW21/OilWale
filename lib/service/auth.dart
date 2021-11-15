import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oilwale/models/customer.dart';
import 'package:oilwale/service/customer_api.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class AuthManager {
  // return customer object on success or false on error
  static Future<dynamic> login(String phone, String pwd, bool customer) async {
    try {
      if (phone == "0123456789" && pwd == "garage" && !customer) {
        return true;
      } else if (phone == "0123456789" && pwd == "customer" && customer) {
        Customer customerdetail = await CustomerAPIManager.getCustomerDetail(
            '61471733b5d80304faa4ccc2');
        print(customerdetail);
        return true;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }
}
