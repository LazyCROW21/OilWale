class CustomerVehicle {
  late final String id;
  late final String model;
  late final String brand;
  late final int? kmperday;
  late final String? numberPlate;
  late final int? currentKM;

  CustomerVehicle(
      {required this.id,
      required this.model,
      required this.brand,
      this.kmperday,
      this.numberPlate,
      this.currentKM});

  CustomerVehicle.fromJSON(Map<String, dynamic> json) {
    this.id = json['customerVehicleId'];
    this.model = json['model'];
    this.brand = json['brand'];
    this.kmperday = json['dailyKMTravelled'];
    this.numberPlate = json['numberPlate'];
    this.currentKM = json['currentKM'];
  }
}
