import 'dart:convert';
import 'package:oilwale/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:oilwale/models/customervehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class CustomerAPIManager {
  // return customer object on success or false on error
  static Future<dynamic> getCustomerDetail(String customerId) async {
    try {
      var client = http.Client();
      String urlStr = base_url + "/customer/" + customerId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        Customer customer = Customer.fromJSON(jsonMap);
        SharedPreferences preferences = await SharedPreferences.getInstance();

        // store in preferences
        preferences.setString('customerId', jsonMap['customerId']);
        preferences.setString('customerName', jsonMap['customerName']);
        preferences.setString(
            'customerPhoneNumber', jsonMap['customerPhoneNumber']);
        preferences.setString('customerAddress', jsonMap['customerAddress']);
        preferences.setString('customerPincode', jsonMap['customerPincode']);
        if (jsonMap['garageReferralCode'] != null) {
          preferences.setString(
              'garageReferralCode', jsonMap['garageReferralCode']);
        }

        return customer;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }

  // adds customer and return bool representing success of operation
  static Future<bool> addCustomer(Map<String, dynamic> data) async {
    try {
      String dataString = jsonEncode(data);
      var client = http.Client();
      String urlStr = base_url + "/customer";
      var url = Uri.parse(urlStr);
      print(dataString);
      var response = await client.post(url,
          body: dataString, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }

  // returns true if phone already registered else false
  static Future<bool> checkPhoneAvailibilty(String phone) async {
    try {
      String dataString = jsonEncode({'data': phone});
      var client = http.Client();
      String urlStr = base_url + "/checkPhoneNumber";
      var url = Uri.parse(urlStr);
      print(dataString);
      var response = await client.post(url,
          body: dataString, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        if (jsonMap['available'] != null && jsonMap['available'] == true) {
          return true;
        }
      }
      return false;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }

  // updates existing customer return true on success
  static Future<bool> updateCustomer(Customer customer) async {
    try {
      Map<String, dynamic> data = {
        "active": true,
        "customerAddress": customer.customerAddress,
        "customerId": customer.customerId,
        "customerName": customer.customerName,
        "customerPhoneNumber": customer.customerPhoneNumber,
        "customerPincode": customer.customerPincode,
        "garageReferralCode": customer.garageReferralCode,
      };
      String dataString = jsonEncode(data);
      var client = http.Client();
      String urlStr = base_url + "/customer";
      var url = Uri.parse(urlStr);
      print(dataString);
      var response = await client.put(url,
          body: dataString, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }

  // returns list of customer vehicle under the specified customer
  static Future<List<CustomerVehicle>> getCustomerVehicles(
      String customerId) async {
    List<CustomerVehicle> customerVehicles = [];
    try {
      var client = http.Client();
      String urlStr = base_url + "/customervehicle/customer/" + customerId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        List jsonMap = jsonDecode(jsonString);
        for (int i = 0; i < jsonMap.length; i++) {
          dynamic element = jsonMap[i]['customerVehicle'];
          element['model'] = jsonMap[i]['vehicle']['vehicleModel'];
          element['brand'] = jsonMap[i]['vehicleCompany']['vehicleCompany'];
          element['suggestedProducts'] = jsonMap[i]['products'];
          customerVehicles.add(CustomerVehicle.fromJSON(element));
          print(element);
        }
        return customerVehicles;
      } else {
        return customerVehicles;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return customerVehicles;
  }

  // return true on successfully adding customervehicle, else false
  static Future<bool> addCustomerVehicle(Map<String, dynamic> data) async {
    try {
      String dataString = jsonEncode(data);
      var client = http.Client();
      String urlStr = base_url + "/customervehicle";
      var url = Uri.parse(urlStr);
      print(dataString);
      var response = await client.post(url,
          body: dataString, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }

  // return on successfully editing customervehicle, else false
  static Future<bool> updateCustomerVehicle(
      CustomerVehicle customerVehicle) async {
    try {
      Map<String, dynamic> data = {
        "active": true,
        "currentKM": customerVehicle.currentKM,
        "customerId": customerVehicle.customerId,
        "customerVehicleId": customerVehicle.customerVehicleId,
        "dailyKMTravel": customerVehicle.kmperday,
        "dailyKMTravelled": customerVehicle.kmperday,
        "numberPlate": customerVehicle.numberPlate,
        "vehicleCompanyId": customerVehicle.vehicleCompanyId,
        "vehicleId": customerVehicle.vehicleId
      };
      String dataString = jsonEncode(data);
      var client = http.Client();
      String urlStr = base_url + "/customervehicle";
      var url = Uri.parse(urlStr);
      print(dataString);
      var response = await client.put(url,
          body: dataString, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }

  // returns true/false upon trying to delete customervehicle under the specified customer
  static Future<bool> deleteCustomerVehicle(String customerVehicleId) async {
    try {
      var client = http.Client();
      String urlStr =
          base_url + "/customervehicle/vehicle/" + customerVehicleId;
      var url = Uri.parse(urlStr);
      var response = await client.delete(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        dynamic jsonMap = jsonDecode(jsonString);
        if (jsonMap['customerVehicleId'] != null &&
            jsonMap['customerVehicleId'] == customerVehicleId) {
          return true;
        }
      }
      return false;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }
}
