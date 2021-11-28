class Garage {
  late  String garageId;
  late  String address;
  late  String? alternateNumber;
  late  String area;
  late  String garageName;
  late  String? gstNumber;
  late  String? image;
  late  String ownerName;
  late  String phoneNumber;
  late String pincode;
  late String? panCard;
  late String referralCode;
  late  int totalScore;
  late int totaCustomer;

  Garage({
    required this.garageId,
    required this.address,
    this.alternateNumber,
    this.panCard,
    required this.area,
    required this.garageName,
    this.gstNumber,
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
    this.panCard =json['panCard'];
    this.address = json['address'];
    this.alternateNumber = json['alternateNumber'];
    this.area = json['area'];
    this.garageName = json['garageName'];
    this.gstNumber = json['gstNumber'];
    this.image = json['image'];
    this.totaCustomer =json['totalCustomer'];
    this.totalScore = json['totalScore'];
    this.ownerName = json['name'];
    this.phoneNumber = json['phoneNumber'];
    this.pincode = json['pincode'];
    this.referralCode = json['referralCode'];
  }
}
