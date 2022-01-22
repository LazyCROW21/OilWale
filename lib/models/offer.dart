import 'package:oilmart/models/product.dart';

class Offer {
  // late bool status;
  late String schemeId;
  late String schemeName;
  late String description;
  late String startedAt;
  late String endsAt;
  late String targetGroup;
  late List<Product> productList;

  Offer({
    // required this.status,
    required this.targetGroup,
    required this.schemeId,
    required this.schemeName,
    required this.description,
    required this.startedAt,
    required this.endsAt,
    required this.productList,
  });

  Offer.fromJSON(Map<String, dynamic> json) {
    // this.status = json['status'];
    Map<String, dynamic> scheme = json['scheme'];
    this.targetGroup = scheme['targetGroup'] ?? '';
    this.schemeId = scheme['schemeId'];
    this.schemeName = scheme['schemeName'];
    this.description = scheme['description'] ?? '';
    this.startedAt = scheme['startedAt'] ?? '';
    this.endsAt = scheme['endedAt'] ?? '';
    List products = json['products'] ?? [];
    this.productList = [];
    for (int i = 0; i < products.length; i++) {
      productList.add(Product.fromJSON(products[i]));
    }
  }
}
