// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

CartResponse cartResponseFromJson(String str) => CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  bool result;
  String message;
  List<Cart> carts;
  var cartCount;
  String subTotal;
  String total;
  String couponDiscount;

  CartResponse({
    required this.result,
    required this.message,
    required this.carts,
    required this.cartCount,
    required this.subTotal,
    required this.total,
    required this.couponDiscount,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    result: json["result"],
    message: json["message"],
    carts: List<Cart>.from(json["carts"].map((x) => Cart.fromJson(x))),
    cartCount: json["cartCount"],
    subTotal: json["subTotal"],
    total: json["total"],
    couponDiscount: json["couponDiscount"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "carts": List<dynamic>.from(carts.map((x) => x.toJson())),
    "cartCount": cartCount,
    "subTotal": subTotal,
    "total": total,
    "couponDiscount": couponDiscount,
  };
}

class Cart {
  var id;
  String slug;
  String name;
  var quantity;
  String thumbnailImage;
  String unit;
  String price;
  String category;

  Cart({
    required this.id,
    required this.slug,
    required this.name,
    required this.quantity,
    required this.thumbnailImage,
    required this.unit,
    required this.price,
    required this.category,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    quantity: json["quantity"],
    thumbnailImage: json["thumbnail_image"],
    unit: json["unit"],
    price: json["price"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "quantity": quantity,
    "thumbnail_image": thumbnailImage,
    "unit": unit,
    "price": price,
    "category": category,
  };
}
