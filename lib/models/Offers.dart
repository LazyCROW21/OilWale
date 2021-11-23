class Offers{
  late bool status;
  late String schemeId;
  late String schemeName;
  late String description;
  late String createdAt;
  late String endsAt;
  late String targetGroup;
  // late String percentage;
  // late String minqty;
  late List productIdList = [];

  Offers(
      {required this.status,
        required this.targetGroup,
        required this.schemeId,
        required this.schemeName,
        required this.description,
        required this.createdAt,
        required this.endsAt,
        // required this.minqty,
        // required this.percentage,
        required this.productIdList,
        });

  Offers.fromJSON(Map<String, dynamic> json) {
    this.status = json['status'];
    this.targetGroup = json['targetGroup'];
    this.schemeId = json['schemeId'];
    this.schemeName = json['schemeName'];
    this.description = json['description'];
    // this.percentage = json['percentage'];
    this.createdAt = json['createdAt']?? " ";
    this.endsAt = json['endedAt'];
    // this.minqty = json['minqty'];
    this.productIdList = json['productList'];
  }
}