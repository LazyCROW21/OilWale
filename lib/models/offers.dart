class Offers{
  late bool status;
  late String schemeId;
  late String schemeName;
  late String description;
  late String startedAt;
  late String endsAt;
  late String targetGroup;
  late List productIdList = [];

  Offers(
      {required this.status,
        required this.targetGroup,
        required this.schemeId,
        required this.schemeName,
        required this.description,
        required this.startedAt,
        required this.endsAt,
        required this.productIdList,
        });

  Offers.fromJSON(Map<String, dynamic> json) {
    this.status = json['status'];
    this.targetGroup = json['targetGroup'];
    this.schemeId = json['schemeId'];
    this.schemeName = json['schemeName'];
    this.description = json['description'];
    this.startedAt = json['startedAt']?? " ";
    this.endsAt = json['endedAt'];
    this.productIdList = json['productList'];
  }
}