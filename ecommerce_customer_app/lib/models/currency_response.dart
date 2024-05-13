// To parse this JSON data, do
//
//     final currencyResponse = currencyResponseFromJson(jsonString);

import 'dart:convert';

CurrencyResponse currencyResponseFromJson(String str) => CurrencyResponse.fromJson(json.decode(str));

String currencyResponseToJson(CurrencyResponse data) => json.encode(data.toJson());

class CurrencyResponse {
  List<CurrencyInfo> data;

  CurrencyResponse({
    required this.data,
  });

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) => CurrencyResponse(
    data: List<CurrencyInfo>.from(json["data"].map((x) => CurrencyInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CurrencyInfo {
  String code;
  String name;
  String symbol;
  var rate;
  var alignment;
  bool isDefault;

  CurrencyInfo({
    required this.code,
    required this.name,
    required this.symbol,
    required this.rate,
    required this.alignment,
    required this.isDefault,
  });

  factory CurrencyInfo.fromJson(Map<String, dynamic> json) => CurrencyInfo(
    code: json["code"],
    name: json["name"],
    symbol: json["symbol"],
    alignment: json["alignment"],
    rate: json["rate"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "symbol": symbol,
    "rate": rate,
    "alignment": alignment,
    "is_default": isDefault,
  };
}
