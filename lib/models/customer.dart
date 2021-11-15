class Customer {
  late bool isActive;
  late String customerId;
  late String customerName;
  late String customerPhoneNumber;
  late String customerAddress;
  late String customerPincode;
  String? garageReferralCode;
  late String createdAt;
  DateTime? updatedAt;

  Customer(
      {required this.isActive,
      required this.customerId,
      required this.customerName,
      required this.customerPhoneNumber,
      required this.customerAddress,
      required this.customerPincode,
      this.garageReferralCode,
      required this.createdAt,
      required this.updatedAt});

  Customer.fromJSON(Map<String, dynamic> json) {
    this.isActive = json['isActive'];
    this.customerId = json['customerId'];
    this.customerName = json['productId'];
    this.customerPhoneNumber = json['customerPhoneNumber'];
    this.customerAddress = json['customerAddress'];
    this.customerPincode = json['customerPincode'];
    this.garageReferralCode = json['garageReferralCode'];
    this.createdAt = json['createdAt'];
    this.updatedAt = json['updatedAt'];
  }
}
