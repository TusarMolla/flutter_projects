// To parse this JSON data, do
//
//     final wishlistResponse = wishlistResponseFromJson(jsonString);

import 'dart:convert';

import 'package:grostore/models/product_mini_response.dart';

WishlistResponse wishlistResponseFromJson(String str) => WishlistResponse.fromJson(json.decode(str));

String wishlistResponseToJson(WishlistResponse data) => json.encode(data.toJson());

class WishlistResponse {
  List<WishlistInfo> data;

  WishlistResponse({
    required this.data,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) => WishlistResponse(
    data: List<WishlistInfo>.from(json["data"].map((x) => WishlistInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WishlistInfo {
  int id;
  ProductMini product;

  WishlistInfo({
    required this.id,
    required this.product,
  });

  factory WishlistInfo.fromJson(Map<String, dynamic> json) => WishlistInfo(
    id: json["id"],
    product: ProductMini.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
  };
}



