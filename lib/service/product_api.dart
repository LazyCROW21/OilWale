import 'dart:convert';
import 'package:oilwale/models/product.dart';
import 'package:http/http.dart' as http;

const String base_url = "https://oilwale.herokuapp.com/api";

class ProductAPIManager {
  // return list of products on success or false on error
  static Future<dynamic> getProducts() async {
    try {
      var client = http.Client();
      String urlStr = base_url + "/getAllProduct";
      var url = Uri.parse(urlStr);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List jsonMap = jsonDecode(jsonString);
        List<Product> products = [];
        jsonMap.forEach((element) {
          products.add(Product.fromJSON(element));
          print(element);
        });
        return products;
      } else {
        return false;
      }
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
    }
    return false;
  }
}
