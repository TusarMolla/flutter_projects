// To parse this JSON data, do
//
//     final pageResponse = pageResponseFromJson(jsonString);

import 'dart:convert';

PageResponse pageResponseFromJson(String str) => PageResponse.fromJson(json.decode(str));

String pageResponseToJson(PageResponse data) => json.encode(data.toJson());

class PageResponse {
  PageInfo data;

  PageResponse({
    required this.data,
  });

  factory PageResponse.fromJson(Map<String, dynamic> json) => PageResponse(
    data: PageInfo.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class PageInfo {
  int id;
  String title;
  String slug;
  String content;
  String metaTitle;
  String metaImage;
  String metaDescription;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<PageLocalization> pageLocalizations;

  PageInfo({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.metaTitle,
    required this.metaImage,
    required this.metaDescription,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.pageLocalizations,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    content: json["content"],
    metaTitle: json["meta_title"],
    metaImage: json["meta_image"],
    metaDescription: json["meta_description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    pageLocalizations: List<PageLocalization>.from(json["page_localizations"].map((x) => PageLocalization.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "content": content,
    "meta_title": metaTitle,
    "meta_image": metaImage,
    "meta_description": metaDescription,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "page_localizations": List<dynamic>.from(pageLocalizations.map((x) => x.toJson())),
  };
}

class PageLocalization {
  int id;
  var pageId;
  String title;
  String content;
  String langKey;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  PageLocalization({
    required this.id,
    required this.pageId,
    required this.title,
    required this.content,
    required this.langKey,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PageLocalization.fromJson(Map<String, dynamic> json) => PageLocalization(
    id: json["id"],
    pageId: json["page_id"],
    title: json["title"],
    content: json["content"],
    langKey: json["lang_key"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "page_id": pageId,
    "title": title,
    "content": content,
    "lang_key": langKey,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
