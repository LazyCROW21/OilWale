class Garage {
  late final String garageId;
  late final String address;
  late final String? alternateNumber;
  late final String area;
  late final String garageName;
  late final String? gstNumber;
  late final String? panCard;
  late final String? image;
  late final String ownerName;
  late final String phoneNumber;
  late final String pincode;
  late final String referralCode;
  late final int totalScore;
  late final int totaCustomer;

  Garage({
    required this.garageId,
    required this.address,
    this.alternateNumber,
    required this.area,
    required this.garageName,
    this.gstNumber,
    this.panCard,
    this.image,
    required this.totaCustomer,
    required this.totalScore,
    required this.ownerName,
    required this.phoneNumber,
    required this.pincode,
    required this.referralCode,
  });

  Garage.fromJSON(Map<String, dynamic> json) {
    this.garageId = json['garageId'];
    this.address = json['address'];
    this.alternateNumber = json['alternateNumber'];
    this.area = json['area'];
    this.garageName = json['garageName'];
    this.gstNumber = json['gstNumber'];
    this.panCard = json['panCard'];
    this.image = json['image'];
    this.totaCustomer = json['totalCustomer'];
    this.totalScore = json['totalScore'];
    this.ownerName = json['name'];
    this.phoneNumber = json['phoneNumber'];
    this.pincode = json['pincode'];
    this.referralCode = json['referralCode'];
  }
}
