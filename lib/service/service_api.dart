import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oilmart/models/service.dart';
import 'package:oilmart/service/garage_api.dart';
import 'package:oilmart/service/product_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class ServiceAPIManager {
  // return TotalNoOfService (int) or -1 on error
  static Future<int> getTotalNoOfService(String customerId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return -1;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr = base_url + "/service/customer/" + customerId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
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

  // return service History
  static Future<List<ServiceHistory>> getServiceHistory(
      String customerVehicleId) async {
    List<ServiceHistory> serviceHistory = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return serviceHistory;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr = base_url + "/service/" + customerVehicleId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        List jsonMap = jsonDecode(jsonString);
        for (int i = 0; i < jsonMap.length; i++) {
          jsonMap[i]['garage'] =
              await GarageAPIManager.getGarageById(jsonMap[i]['garageId']);
          List productIdList = jsonMap[i]['productId'];
          List<dynamic> products = [];
          for (int j = 0; j < productIdList.length; j++) {
            products.add(await ProductAPIManager.getProduct(productIdList[j]));
          }
          jsonMap[i]['products'] = products;
          serviceHistory.add(ServiceHistory.fromJSON(jsonMap[i]));
        }
        return serviceHistory;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return serviceHistory;
  }
}
