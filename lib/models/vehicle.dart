class Vehicle {
  late final String vehicleId;
  late final String vehicleModel;
  late final String vehicleCompanyId;
  late final String? vehicleCompany;
  late final List<String>? suggestedProduct;

  Vehicle({
    required this.vehicleId,
    required this.vehicleModel,
    required this.vehicleCompanyId,
    this.vehicleCompany,
    this.suggestedProduct,
  });

  Vehicle.fromJSON(Map<String, dynamic> json) {
    this.vehicleId = json['vehicleId'];
    this.vehicleModel = json['vehicleModel'];
    this.vehicleCompanyId =
        json['vehicleCompanyId'] ?? json['vehicleCompany']!['vehicleCompanyId'];
    this.vehicleCompany = (json['vehicleCompany'] != null
        ? json['vehicleCompany']['vehicleCompany']
        : '');
    // this.suggestedProduct = json['suggestedProduct'];
  }
}
