class CustomerVehicle {
  late final String customerVehicleId;
  late final String vehicleId;
  late final String vehicleCompanyId;
  late final String model;
  late final String brand;
  late final int? kmperday;
  late final String? numberPlate;
  late final int? currentKM;
  late final List<dynamic>? suggestedProducts;

  CustomerVehicle(
      {required this.customerVehicleId,
      required this.model,
      required this.brand,
      required this.vehicleId,
      required this.vehicleCompanyId,
      this.kmperday,
      this.numberPlate,
      this.currentKM,
      this.suggestedProducts});

  CustomerVehicle.fromJSON(Map<String, dynamic> json) {
    this.customerVehicleId = json['customerVehicleId'];
    this.vehicleId = json['vehicleId'];
    this.vehicleCompanyId = json['vehicleCompanyId'];
    this.model = json['model'];
    this.brand = json['brand'];
    this.kmperday = json['dailyKMTravel'];
    this.numberPlate = json['numberPlate'];
    this.currentKM = json['currentKM'];
    this.suggestedProducts = json['suggestedProducts'];
  }
}
