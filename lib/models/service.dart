import 'package:oilwale/models/garage.dart';
import 'package:oilwale/models/product.dart';

class ServiceHistory {
  late final String serviceId;
  late final String customerId;
  late final String customerVehicleId;
  late final String dateOfService;
  late final String garageId;
  late final Garage garage;
  late final List<Product> productList;

  ServiceHistory(
      {required this.serviceId,
      required this.customerId,
      required this.customerVehicleId,
      required this.dateOfService,
      required this.garageId,
      required this.productList});

  ServiceHistory.fromJSON(Map<String, dynamic> json) {
    this.serviceId = json['serviceId'];
    this.customerId = json['customerId'];
    this.customerVehicleId = json['customerVehicleId'];
    this.dateOfService = json['dateOfService'];
    this.garageId = json['garageId'];

    if (json['garage'] != null) {
      this.garage = Garage.fromJSON(json['garage']);
    } else {
      this.garage = Garage(
          address: '',
          area: '',
          garageId: '',
          garageName: '',
          ownerName: '',
          phoneNumber: '',
          pincode: '',
          referralCode: '',
          totaCustomer: 0,
          totalScore: 0);
    }
    List products = json['products'] ?? [];
    this.productList = [];
    for (int i = 0; i < products.length; i++) {
      this.productList.add(Product.fromJSON(products[i]));
    }
  }
}
