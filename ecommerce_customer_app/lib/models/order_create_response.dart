// To parse this JSON data, do
//
//     final orderCreateResponse = orderCreateResponseFromJson(jsonString);

import 'dart:convert';

OrderCreateResponse orderCreateResponseFromJson(String str) => OrderCreateResponse.fromJson(json.decode(str));

String orderCreateResponseToJson(OrderCreateResponse data) => json.encode(data.toJson());

class OrderCreateResponse {

  bool result;
  int orderCode;
  String message;

  factory OrderCreateResponse.init(){
    return OrderCreateResponse(message: "",orderCode: 0,result: false);
  }


  OrderCreateResponse({
    required this.result,
    required this.orderCode,
    required this.message,
  });

  factory OrderCreateResponse.fromJson(Map<String, dynamic> json) => OrderCreateResponse(
    result: json["result"],
    orderCode: json["order_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "order_code": orderCode,
    "message": message,
  };
}
