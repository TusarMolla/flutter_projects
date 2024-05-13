// To parse this JSON data, do
//
//     final homeBannerResponse = homeBannerResponseFromJson(jsonString);

import 'dart:convert';

HomeBannerResponse homeBannerResponseFromJson(String str) => HomeBannerResponse.fromJson(json.decode(str));

String homeBannerResponseToJson(HomeBannerResponse data) => json.encode(data.toJson());

class HomeBannerResponse {
  List<BannerData> data;

  HomeBannerResponse({
    required this.data,
  });

  factory HomeBannerResponse.fromJson(Map<String, dynamic> json) => HomeBannerResponse(
    data: List<BannerData>.from(json["data"].map((x) => BannerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BannerData {
  String image;
  String link;

  BannerData({
    required this.image,
    required this.link,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    image: json["image"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "link": link,
  };
}
