import 'dart:convert';
import 'package:oilmart/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String base_url = "https://oilwale.herokuapp.com/api";

class ProductAPIManager {
  // return list of products on success or false on error
  static Future<dynamic> getAllProducts() async {
    List<Product> products = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return products;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr = base_url + "/products";
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          products.add(Product.fromJSON(element));
          // print(element);
        });
      }
      return products;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return products;
  }

  // return full details of particular product
  static Future<dynamic> getProduct(String productId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return null;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr = base_url + "/product/" + productId;
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        dynamic jsonMap = jsonDecode(jsonString);
        return jsonMap;
      }
      return null;
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return null;
  }

  // return the search result from all product list
  static Future<dynamic> searchProduct(String inp) async {
    List<Product> products = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token') ?? '';
    if (authToken == '') {
      return products;
    }
    Map<String, String> reqHeader = {
      'Authorization': 'Bearer $authToken',
      // 'Content-Type': 'application/json'
    };
    try {
      var client = http.Client();
      String urlStr = base_url + "/product/search/" + Uri.encodeComponent(inp);
      var url = Uri.parse(urlStr);
      var response = await client.get(url, headers: reqHeader);
      if (response.statusCode == 200) {
        // List<Product> products = [];
        var jsonString = response.body;
        List jsonMap = jsonDecode(jsonString);
        jsonMap.forEach((element) {
          products.add(Product.fromJSON(element));
          // print(element);
        });
        return products;
      } else {
        return products;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return products;
  }
}
