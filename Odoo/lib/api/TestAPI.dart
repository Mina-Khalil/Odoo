// To parse this JSON data, do
//
//     final getAlbum = getAlbumFromJson(jsonString);

import 'dart:convert';

List<GetAlbum> getAlbumFromJson(String str) =>
    List<GetAlbum>.from(json.decode(str).map((x) => GetAlbum.fromJson(x)));

String getAlbumToJson(List<GetAlbum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAlbum {
  GetAlbum({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int? userId;
  int? id;
  String? title;
  String? body;

  factory GetAlbum.fromJson(Map<String, dynamic> json) => GetAlbum(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
