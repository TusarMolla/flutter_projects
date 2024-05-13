class CategoryInfo {
  var id;
  String name;
  var products;
  String thumbnailImage;

  CategoryInfo({
    required this.id,
    required this.name,
    required this.products,
    required this.thumbnailImage,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
    id: json["id"],
    name: json["name"],
    products: json["products"],
    thumbnailImage: json["thumbnail_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "products": products,
    "thumbnail_image": thumbnailImage,
  };
}