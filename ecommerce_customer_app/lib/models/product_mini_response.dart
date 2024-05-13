// To parse this JSON data, do
//
//     final productMiniResponse = productMiniResponseFromJson(jsonString);

import 'dart:convert';

import 'package:grostore/models/common/category_info.dart';

import 'product_details_response.dart';

ProductMiniResponse productMiniResponseFromJson(String str) => ProductMiniResponse.fromJson(json.decode(str));

String productMiniResponseToJson(ProductMiniResponse data) => json.encode(data.toJson());

class ProductMiniResponse {
  List<ProductMini> data;

  ProductMiniResponse({
    required this.data,
  });

  factory ProductMiniResponse.fromJson(Map<String, dynamic> json) => ProductMiniResponse(
    data: List<ProductMini>.from(json["data"].map((x) => ProductMini.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductMini {
  var id;
  String name;
  String slug;
  String brand;
  String unit;
  String thumbnailImage;
  String price;
  bool isDiscounted;
  var discount;
  var rewardPovars;
  List<CategoryInfo> categories;
  List<Variation> variations;

  ProductMini({
    required this.id,
    required this.variations,
    required this.name,
    required this.slug,
    required this.brand,
    required this.unit,
    required this.thumbnailImage,
    required this.price,
    required this.isDiscounted,
    required this.discount,
    required this.rewardPovars,
    required this.categories,
  });

  factory ProductMini.fromJson(Map<String, dynamic> json) => ProductMini(
    id: json["id"],
    name: json["name"],
    variations:json["variations"]==[]?[]: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
    slug: json["slug"],
    brand: json["brand"],
    unit: json["unit"],
    thumbnailImage: json["thumbnail_image"],
    price: json["price"],
    isDiscounted: json["is_discounted"],
    discount: json["discount"],
    rewardPovars: json["reward_povars"],
    categories: List<CategoryInfo>.from(json["categories"].map((x) => CategoryInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "brand": brand,
    "unit": unit,
    "thumbnail_image": thumbnailImage,
    "price": price,
    "is_discounted": isDiscounted,
    "discount": discount,
    "reward_povars": rewardPovars,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}