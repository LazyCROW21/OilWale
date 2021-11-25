import 'package:oilwale/models/product.dart';

int cartnum = 0;
var dateofcreation = DateTime.now();
var dateofOffers = dateofcreation.subtract(Duration(days: 30));
List<Product> cartProduct = [];