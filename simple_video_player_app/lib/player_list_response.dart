// To parse this JSON data, do
//
//     final playerListResponse = playerListResponseFromJson(jsonString);

import 'dart:convert';

PlayerListResponse playerListResponseFromJson(String str) => PlayerListResponse.fromJson(json.decode(str));

String playerListResponseToJson(PlayerListResponse data) => json.encode(data.toJson());

class PlayerListResponse {
  Links links;
  int total;
  int page;
  int pageSize;
  List<VideoInfo> results;

  PlayerListResponse({
    required this.links,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.results,
  });

  factory PlayerListResponse.fromJson(Map<String, dynamic> json) => PlayerListResponse(
    links: Links.fromJson(json["links"]),
    total: json["total"],
    page: json["page"],
    pageSize: json["page_size"],
    results: List<VideoInfo>.from(json["results"].map((x) => VideoInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "links": links.toJson(),
    "total": total,
    "page": page,
    "page_size": pageSize,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Links {
  int? next;
  dynamic previous;

  Links({
     this.next,
    required this.previous,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    next: json["next"],
    previous: json["previous"],
  );

  Map<String, dynamic> toJson() => {
    "next": next,
    "previous": previous,
  };
}

class VideoInfo {
  String thumbnail;
  int id;
  String title;
  DateTime dateAndTime;
  String slug;
  DateTime createdAt;
  String manifest;
  int liveStatus;
  String? liveManifest;
  bool isLive;
  String channelImage;
  String channelName;
  String? channelUsername;
  bool isVerified;
  String channelSlug;
  String channelSubscriber;
  int channelId;
  String type;
  String viewers;
  String duration;

  VideoInfo({
    required this.thumbnail,
    required this.id,
    required this.title,
    required this.dateAndTime,
    required this.slug,
    required this.createdAt,
    required this.manifest,
    required this.liveStatus,
    required this.liveManifest,
    required this.isLive,
    required this.channelImage,
    required this.channelName,
    required this.channelUsername,
    required this.isVerified,
    required this.channelSlug,
    required this.channelSubscriber,
    required this.channelId,
    required this.type,
    required this.viewers,
    required this.duration,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) => VideoInfo(
    thumbnail: json["thumbnail"],
    id: json["id"],
    title: json["title"],
    dateAndTime: DateTime.parse(json["date_and_time"]),
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    manifest: json["manifest"],
    liveStatus: json["live_status"],
    liveManifest: json["live_manifest"],
    isLive: json["is_live"],
    channelImage: json["channel_image"],
    channelName: json["channel_name"],
    channelUsername: json["channel_username"],
    isVerified: json["is_verified"],
    channelSlug: json["channel_slug"],
    channelSubscriber: json["channel_subscriber"],
    channelId: json["channel_id"],
    type: json["type"],
    viewers: json["viewers"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "thumbnail": thumbnail,
    "id": id,
    "title": title,
    "date_and_time": dateAndTime.toIso8601String(),
    "slug": slug,
    "created_at": createdAt.toIso8601String(),
    "manifest": manifest,
    "live_status": liveStatus,
    "live_manifest": liveManifest,
    "is_live": isLive,
    "channel_image": channelImage,
    "channel_name": channelName,
    "channel_username": channelUsername,
    "is_verified": isVerified,
    "channel_slug": channelSlug,
    "channel_subscriber": channelSubscriber,
    "channel_id": channelId,
    "type": type,
    "viewers": viewers,
    "duration": duration,
  };
}
