// To parse this JSON data, do
//
//     final ratingResponse = ratingResponseFromJson(jsonString);

import 'dart:convert';

RatingResponse ratingResponseFromJson(String str) => RatingResponse.fromJson(json.decode(str));

String ratingResponseToJson(RatingResponse data) => json.encode(data.toJson());

class RatingResponse {
  bool? success;
  double? rating;

  RatingResponse({
    this.success,
    this.rating,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) => RatingResponse(
    success: json["success"],
    rating: json["rating"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "rating": rating,
  };
}
