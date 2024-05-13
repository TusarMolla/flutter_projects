// To parse this JSON data, do
//
//     final orderDetailsResponse = orderDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:grostore/models/product_mini_response.dart';

OrderDetailsResponse orderDetailsResponseFromJson(String str) => OrderDetailsResponse.fromJson(json.decode(str));

String orderDetailsResponseToJson(OrderDetailsResponse data) => json.encode(data.toJson());

class OrderDetailsResponse {
  OrderDetailsInfo data;

  OrderDetailsResponse({
    required this.data,
  });

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) => OrderDetailsResponse(
    data: OrderDetailsInfo.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class OrderDetailsInfo {
  int id;
  String code;
  String date;
  IngAddress? shippingAddress;
  IngAddress? billingAddress;
  List<Item> items;
  String status;
  String payment_method;
  String subTotalAmount;
  String totalTips;
  String totalShippingCost;
  String couponDiscountAmount;
  String totalPrice;

  OrderDetailsInfo({
    required this.id,
    required this.code,
    required this.date,
    this.shippingAddress,
    this.billingAddress,
    required this.items,
    required this.status,
    required this.payment_method,
    required this.subTotalAmount,
    required this.totalTips,
    required this.totalShippingCost,
    required this.totalPrice,
    required this.couponDiscountAmount
  });

  factory OrderDetailsInfo.fromJson(Map<String, dynamic> json) => OrderDetailsInfo(
    id: json["id"],
    code: json["order_code"],
    date: json["date"],
    shippingAddress:json["shipping_address"]==null?null: IngAddress.fromJson(json["shipping_address"]),
    billingAddress: json["billing_address"]==null?null:IngAddress.fromJson(json["billing_address"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    status: json["status"],
    payment_method: json["payment_method"],
    subTotalAmount: json["sub_total_amount"],
    totalTips: json["total_tips"],
    totalShippingCost: json["total_shipping_cost"],
    couponDiscountAmount: json["coupon_discount_amount"],
    totalPrice: json["total_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "shipping_address": shippingAddress?.toJson(),
    "billing_address": billingAddress?.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "status": status,
    "sub_total_amount": subTotalAmount,
    "total_tips": totalTips,
    "total_shipping_cost": totalShippingCost,
    "total_price": totalPrice,
  };
}

class IngAddress {
  var id;
  var userId;
  var countryId;
  String countryName;
  var stateId;
  String stateName;
  var cityId;
  String cityName;
  String address;
  var isDefault;

  IngAddress({
    required this.id,
    required this.userId,
    required this.countryId,
    required this.countryName,
    required this.stateId,
    required this.stateName,
    required this.cityId,
    required this.cityName,
    required this.address,
    required this.isDefault,
  });

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
    id: json["id"],
    userId: json["user_id"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    address: json["address"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "country_id": countryId,
    "country_name": countryName,
    "state_id": stateId,
    "state_name": stateName,
    "city_id": cityId,
    "city_name": cityName,
    "address": address,
    "is_default": isDefault,
  };
}

class Item {
  var id;
  ProductMini? product;
  var qty;
  String unitPrice;
  String totalPrice;
  var refund_status;

  Item({
    required this.id,
    this.product,
    required this.qty,
    required this.unitPrice,
    required this.totalPrice,
    required this.refund_status,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    product: ProductMini.fromJson(json["product"]),
    qty: json["qty"],
    unitPrice: json["unit_price"],
    totalPrice: json["total_price"],
    refund_status: json["refund_status"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "product": product?.toJson(),
    "qty": qty,
    "unit_price": unitPrice,
    "total_price": totalPrice,
    "refund_status": refund_status,
  };
}

