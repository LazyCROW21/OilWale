class CustomerVehicle {
  late final String customerVehicleId;
  late final String vehicleId;
  late final String model;
  late final String brand;
  late final int? kmperday;
  late final String? numberPlate;
  late final int? currentKM;
  late final List<String>? suggestedProducts;

  CustomerVehicle(
      {required this.customerVehicleId,
      required this.model,
      required this.brand,
      required this.vehicleId,
      this.kmperday,
      this.numberPlate,
      this.currentKM,
      this.suggestedProducts});

  CustomerVehicle.fromJSON(Map<String, dynamic> json) {
    this.customerVehicleId = json['customerVehicleId'];
    this.vehicleId = json['vehicleId'];
    this.model = json['model'];
    this.brand = json['brand'];
    this.kmperday = json['dailyKMTravel'];
    this.numberPlate = json['numberPlate'];
    this.currentKM = json['currentKM'];
    this.suggestedProducts = json['suggestedProducts'];
  }
}
