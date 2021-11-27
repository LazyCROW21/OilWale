class Product {
  late final String id;
  late final String name;
  late final String grade;
  late final String specification;
  late final String packingSize;
  late final String? image;

  Product(
      {required this.id,
      required this.name,
      required this.grade,
      required this.specification,
      required this.packingSize,
      this.image});

  Product.fromJSON(Map<String, dynamic> json) {
    this.id = json['productId'];
    this.name = json['productName'];
    this.grade = json['grade'];
    this.specification = json['specification'];
    this.packingSize = json['packingSize'];
    this.image = json['productImage'];
  }
}
