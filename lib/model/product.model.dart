class ProductModel {
  String? productIndex;
  bool? isFav;
  String? image;
  String? name;
  double? price;
  String? filter;

  ProductModel({
    this.productIndex,
    this.isFav,
    this.image,
    this.name,
    this.price,
    this.filter,
  });

  ProductModel.fromJson(
      Map<String, dynamic> json, String productIndexFromJson) {
    productIndex = productIndexFromJson;
    isFav = json['isFav'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    filter = json['filter'];
  }
}
