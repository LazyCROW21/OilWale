import 'dart:convert';
import 'package:oilmart/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:oilmart/models/customervehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class CustomerAPIManager {
  // return customer object on success or false on error
  static Future<dynamic> getCustomerDetail(String customerId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      print('Auth Token not found');
      print(authToken);
      return false;
    }
    Map<String, String> reqHeader = {'Authorization': 'Bearer $authToken'};
    // print(reqHeader);
    try {
      var client = http.Client();
      String urlStr = base_url + "/customer/" + customerId;
      print(urlStr);
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        Customer customer = Customer.fromJSON(jsonMap);

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
        print('ASDASDASD');
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return false;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };
    try {
      String dataString = jsonEncode(data);
      var client = http.Client();
      String urlStr = base_url + "/customer";
      var url = Uri.parse(urlStr);
      print(dataString);
      var response =
          await client.post(url, body: dataString, headers: reqHeader);
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return false;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };
    try {
      String dataString = jsonEncode({'data': phone});
      var client = http.Client();
      String urlStr = base_url + "/checkPhoneNumber";
      var url = Uri.parse(urlStr);
      print(dataString);
      var response =
          await client.post(url, body: dataString, headers: reqHeader);
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return false;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };
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
      var response =
          await client.put(url, body: dataString, headers: reqHeader);
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return <CustomerVehicle>[];
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    List<CustomerVehicle> customerVehicles = [];
    try {
      var client = http.Client();
      String urlStr = base_url + "/customervehicle/customer/" + customerId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return false;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };
    try {
      String dataString = jsonEncode(data);
      var client = http.Client();
      String urlStr = base_url + "/customervehicle";
      var url = Uri.parse(urlStr);
      print(dataString);
      var response =
          await client.post(url, body: dataString, headers: reqHeader);
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return false;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };
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
      var response =
          await client.put(url, body: dataString, headers: reqHeader);
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return false;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr =
          base_url + "/customervehicle/vehicle/" + customerVehicleId;
      var url = Uri.parse(urlStr);
      var response = await client.delete(url, headers: reqHeader);
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
