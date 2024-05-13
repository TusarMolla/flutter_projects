// To parse this JSON data, do
//
//     final couponResponse = couponResponseFromJson(jsonString);

import 'dart:convert';

CouponResponse couponResponseFromJson(String str) => CouponResponse.fromJson(json.decode(str));

String couponResponseToJson(CouponResponse data) => json.encode(data.toJson());

class CouponResponse {
  List<CouponInfo> data;

  CouponResponse({
    required this.data,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) => CouponResponse(
    data: List<CouponInfo>.from(json["data"].map((x) => CouponInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CouponInfo {
  var id;
  var shopId;
  String banner;
  String code;
  String discountType;
  var discountValue;
  var isFreeShipping;
  String startDate;
  String endDate;
  var minSpend;
  var maxDiscountAmount;
  var customerUsageLimit;
  String? productIds;
  String? categoryIds;

  CouponInfo({
    required this.id,
    required this.shopId,
    required this.banner,
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.isFreeShipping,
    required this.startDate,
    required this.endDate,
    required this.minSpend,
    required this.maxDiscountAmount,
    required this.customerUsageLimit,
    this.productIds,
    this.categoryIds,
  });

  factory CouponInfo.fromJson(Map<String, dynamic> json) => CouponInfo(
    id: json["id"],
    shopId: json["shop_id"],
    banner: json["banner"],
    code: json["code"],
    discountType: json["discount_type"],
    discountValue: json["discount_value"],
    isFreeShipping: json["is_free_shipping"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    minSpend: json["min_spend"],
    maxDiscountAmount: json["max_discount_amount"],
    customerUsageLimit: json["customer_usage_limit"],
    productIds: json["product_ids"],
    categoryIds: json["category_ids"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "banner": banner,
    "code": code,
    "discount_type": discountType,
    "discount_value": discountValue,
    "is_free_shipping": isFreeShipping,
    "start_date": startDate,
    "end_date": endDate,
    "min_spend": minSpend,
    "max_discount_amount": maxDiscountAmount,
    "customer_usage_limit": customerUsageLimit,
    "product_ids": productIds,
    "category_ids": categoryIds,
  };
}
