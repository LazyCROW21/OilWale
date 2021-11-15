class Offers{
  late bool isActive;
  late String offerId;
  late String offerName;
  late String description;
  late String createdAt;
  late String endsAt;
  late String percentage;
  late String minqty;
  late String productId;

  Offers(
      {required this.isActive,
        required this.offerId,
        required this.offerName,
        required this.description,
        required this.createdAt,
        required this.endsAt,
        required this.minqty,
        required this.percentage,
        required this.productId,
        });

  Offers.fromJSON(Map<String, dynamic> json) {
    this.isActive = json['isActive'];
    this.offerId = json['offerId'];
    this.offerName = json['offerName'];
    this.description = json['description'];
    this.percentage = json['percentage'];
    this.createdAt = json['createdAt'];
    this.endsAt = json['endsAt'];
    this.minqty = json['minqty'];
    this.productId = json['productId'];
  }
}