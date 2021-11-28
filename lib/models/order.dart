
class Order {
  late String orderId;
  late List productList = [];
  late int status;
  late String placedAt;
  late String acceptedAt;
  late String completedAt;

  Order(
      {required this.orderId,
    required this.productList,
    required this.status,
    required this.acceptedAt,
    required this.completedAt,
    required this.placedAt
  });

  Order.fromJSON(Map<String, dynamic> json)
  {
    this.orderId = json['orderId'];
    this.productList = json['product'];
    this.status = json['status'];
    this.placedAt = json['placedAt'];
    this.acceptedAt = json['acceptedAt'];
    this.completedAt = json['completedAt'];
  }

}