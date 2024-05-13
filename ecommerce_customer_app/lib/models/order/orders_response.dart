// To parse this JSON data, do
//
//     final ordersResponse = ordersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:grostore/models/product_mini_response.dart';

OrdersResponse ordersResponseFromJson(String str) => OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse data) => json.encode(data.toJson());

class OrdersResponse {
  List<OrderInfo> data;
  Links links;
  Meta meta;

  OrdersResponse({
    required this.data,
    required this.links,
    required this.meta,
  });
factory OrdersResponse.init(){
  return OrdersResponse(data: [], links: Links.fromJson({}), meta: Meta.fromJson({}));

}
  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
    data: List<OrderInfo>.from(json["data"].map((x) => OrderInfo.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class OrderInfo {
  int id;
  Item item;
  String status;
  DateTime date;

  OrderInfo({
    required this.id,
    required this.item,
    required this.status,
    required this.date,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) 
      {
      return  OrderInfo(
          id: json["id"],
        item: Item.fromJson(json["items"]),
          status: json["status"],
          date: DateTime.parse(json["date"]),
        );
      }

  Map<String, dynamic> toJson() => {
    "id": id,
    "items": item.toJson(),
    "status": statusValues.reverse[status],
    "date": date.toIso8601String(),
  };
}

class Item {
  ProductMini? product;
  var qty;
  String unitPrice;
  String totalPrice;
  var isRefunded;

  Item({
    required this.product,
    required this.qty,
    required this.unitPrice,
    required this.totalPrice,
    required this.isRefunded,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    product: ProductMini.fromJson(json["product"]),
    qty: json["qty"],
    unitPrice: json["unit_price"],
    totalPrice: json["total_price"],
    isRefunded: json["is_refunded"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "qty": qty,
    "unit_price": unitPrice,
    "total_price": totalPrice,
    "is_refunded": isRefunded,
  };
}









enum Status { ORDER_PLACED, DELIVERED, PROCESSING }

final statusValues = EnumValues({
  "delivered": Status.DELIVERED,
  "order_placed": Status.ORDER_PLACED,
  "processing": Status.PROCESSING
});

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int currentPage;
  int? from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int? to;
  int total;

  Meta({
    required this.currentPage,
    this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
     this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
