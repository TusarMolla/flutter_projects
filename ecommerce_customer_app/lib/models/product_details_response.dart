// To parse this JSON data, do
//
//     final productDetailsResponse = productDetailsResponseFromJson(jsonString);

import 'dart:convert';

ProductDetailsResponse productDetailsResponseFromJson(String str) => ProductDetailsResponse.fromJson(json.decode(str));

String productDetailsResponseToJson(ProductDetailsResponse data) => json.encode(data.toJson());

class ProductDetailsResponse {
  ProductDetailsInfo data;
  bool result;
  var status;

  ProductDetailsResponse({
    required this.data,
    required this.result,
    required this.status,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) => ProductDetailsResponse(
    data: ProductDetailsInfo.fromJson(json["data"]),
    result: json["result"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "result": result,
    "status": status,
  };
}

class ProductDetailsInfo {
  var id;
  List<Variation> variations;
  List<VariationMaterial> variationMaterials;
  String slug;
  String name;
  String thumbnailImage;
  List<String> galleryImages;
  String price;
  double mainPrice;
  bool isDiscounted;
  var discount;
  String? shortDescription;
  String? description;
  String? brand;
  String? unit;
  var stock;
  var rewardPovars;
  List<Category> categories;

  ProductDetailsInfo({
    required this.id,
    required this.variations,
    required this.variationMaterials,
    required this.slug,
    required this.name,
    required this.thumbnailImage,
    required this.galleryImages,
    required this.price,
    required this.mainPrice,
    required this.isDiscounted,
    required this.discount,
    this.shortDescription,
    this.description,
    this.brand,
    this.unit,
    required this.stock,
    required this.rewardPovars,
    required this.categories,
  });

  factory ProductDetailsInfo.fromJson(Map<String, dynamic> json) => ProductDetailsInfo(
    id: json["id"],
    variations:json["variations"]==[]?[]: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
    variationMaterials:json["variation_materials"]==[]?[]: List<VariationMaterial>.from(json["variation_materials"].map((x) => VariationMaterial.fromJson(x))),
    slug: json["slug"],
    name: json["name"],
    thumbnailImage: json["thumbnail_image"],
    galleryImages: List<String>.from(json["gallery_images"].map((x) => x)),
    price: json["price"],
    mainPrice: json["main_price"]?.toDouble(),
    isDiscounted: json["is_discounted"],
    discount: json["discount"],
    shortDescription: json["short_description"],
    description: json["description"],
    brand: json["brand"],
    unit: json["unit"],
    stock: json["stock"],
    rewardPovars: json["reward_povars"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );
  factory ProductDetailsInfo.init() => ProductDetailsInfo(
    id: 0,
    variations: [],
    variationMaterials: [],
    slug:"",
    name: '',
    thumbnailImage: '',
    galleryImages:[],
    price: "",
    mainPrice: 0.0,
    isDiscounted: false,
    discount: "",
    shortDescription: "",
    description: "",
    brand: "",
    unit: "",
    stock: "",
    rewardPovars: "",
    categories: []
    );

  Map<String, dynamic> toJson() => {
    "id": id,
    "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
    "variation_materials": List<dynamic>.from(variationMaterials.map((x) => x.toJson())),
    "slug": slug,
    "name": name,
    "thumbnail_image": thumbnailImage,
    "gallery_images": List<dynamic>.from(galleryImages.map((x) => x)),
    "price": price,
    "main_price": mainPrice,
    "is_discounted": isDiscounted,
    "discount": discount,
    "short_description": shortDescription,
    "description": description,
    "brand": brand,
    "unit": unit,
    "stock": stock,
    "reward_povars": rewardPovars,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  var id;
  String name;
  var products;
  String thumbnailImage;

  Category({
    required this.id,
    required this.name,
    required this.products,
    required this.thumbnailImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

class VariationMaterial {
  var id;
  String name;
  List<Value> values;

  VariationMaterial({
    required this.id,
    required this.name,
    required this.values,
  });

  factory VariationMaterial.fromJson(Map<String, dynamic> json) => VariationMaterial(
    id: json["id"],
    name: json["name"],
    values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "values": List<dynamic>.from(values.map((x) => x.toJson())),
  };
}

class Value {
  var id;
  String name;
  String? code;

  Value({
    required this.id,
    required this.name,
    this.code,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}

class Variation {
  var id;
  var productId;
  String? variationKey;
  String? sku;
  String? code;
  int sock;
  var price;


  Variation({
    required this.id,
    required this.productId,
    this.variationKey,
     this.sku,
     this.code,
    required this.sock,
    required this.price,

  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    id: json["id"],
    productId: json["product_id"],
    variationKey: json["variation_key"],
    sku: json["sku"],
    sock: json["stock"],
    code: json["code"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "variation_key": variationKey,
    "sku": sku,
    "stock": sock,
    "code": code,
    "price": price,

  };
}
