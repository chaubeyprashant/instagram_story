import 'dart:convert';

import '../../domain/entities.dart';

List<StoryModel> storyModelFromJson(String str) =>
    List<StoryModel>.from(json.decode(str).map((x) => StoryModel.fromJson(x)));

String storyModelToJson(List<StoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoryModel extends Story {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  StoryModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  }) : super(
            albumId: albumId,
            id: id,
            title: title,
            url: url,
            thumbnailUrl: thumbnailUrl);

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
