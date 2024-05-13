// To parse this JSON data, do
//
//     final orderSummeryResponse = orderSummeryResponseFromJson(jsonString);

import 'dart:convert';

OrderSummeryResponse orderSummeryResponseFromJson(String str) => OrderSummeryResponse.fromJson(json.decode(str));

String orderSummeryResponseToJson(OrderSummeryResponse data) => json.encode(data.toJson());

class OrderSummeryResponse {
  String subTotal;
  String tax;
  String shippingCharge;
  bool isFreeShipping;
  String couponDiscount;
  String total;

  OrderSummeryResponse({
    required this.subTotal,
    required this.tax,
    required this.shippingCharge,
    required this.isFreeShipping,
    required this.couponDiscount,
    required this.total,
  });

  factory OrderSummeryResponse.fromJson(Map<String, dynamic> json) => OrderSummeryResponse(
    subTotal: json["sub_total"],
    tax: json["tax"],
    shippingCharge: json["shipping_charge"],
    isFreeShipping: json["is_free_shipping"],
    couponDiscount: json["coupon_discount"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "sub_total": subTotal,
    "tax": tax,
    "shipping_charge": shippingCharge,
    "is_free_shipping": isFreeShipping,
    "coupon_discount": couponDiscount,
    "total": total,
  };
}
