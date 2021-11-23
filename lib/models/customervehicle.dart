class CustomerVehicle {
  late String customerVehicleId;
  late String customerId;
  late String vehicleId;
  late String vehicleCompanyId;
  late String model;
  late String brand;
  late int kmperday;
  late String numberPlate;
  late int currentKM;
  late List<dynamic>? suggestedProducts;

  CustomerVehicle(
      {required this.customerVehicleId,
      required this.customerId,
      required this.model,
      required this.brand,
      required this.vehicleId,
      required this.vehicleCompanyId,
      required this.kmperday,
      required this.numberPlate,
      required this.currentKM,
      this.suggestedProducts});

  CustomerVehicle.fromJSON(Map<String, dynamic> json) {
    this.customerVehicleId = json['customerVehicleId'] ?? '';
    this.customerId = json['customerId'] ?? '';
    this.vehicleId = json['vehicleId'] ?? '';
    this.vehicleCompanyId = json['vehicleCompanyId'] ?? '';
    this.model = json['model'] ?? '';
    this.brand = json['brand'] ?? '';
    this.kmperday = json['dailyKMTravel'] ?? -1;
    this.numberPlate = json['numberPlate'] ?? '';
    this.currentKM = json['currentKM'] ?? -1;
    this.suggestedProducts = json['suggestedProducts'];
  }
}
