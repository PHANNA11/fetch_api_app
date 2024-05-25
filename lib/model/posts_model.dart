// To parse this JSON data, do
//
//     final postsModel = postsModelFromJson(jsonString);

import 'dart:convert';

List<PostsModel> postsModelFromJson(String str) =>
    List<PostsModel>.from(json.decode(str).map((x) => PostsModel.fromJson(x)));

String postsModelToJson(List<PostsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostsModel {
  int? id;
  String? slug;
  String? url;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  Status? status;
  Category? category;
  String? publishedAt;
  String? updatedAt;
  int? userId;

  PostsModel({
    this.id,
    this.slug,
    this.url,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.status,
    this.category,
    this.publishedAt,
    this.updatedAt,
    this.userId,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        id: json["id"],
        slug: json["slug"],
        url: json["url"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        thumbnail: json["thumbnail"],
        status: statusValues.map[json["status"]]!,
        category: categoryValues.map[json["category"]]!,
        publishedAt: json["publishedAt"],
        updatedAt: json["updatedAt"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "url": url,
        "title": title,
        "content": content,
        "image": image,
        "thumbnail": thumbnail,
        "status": statusValues.reverse[status],
        "category": categoryValues.reverse[category],
        "publishedAt": publishedAt,
        "updatedAt": updatedAt,
        "userId": userId,
      };
}

enum Category { ELEMENTUM, IPSUM, JSONPLACEHOLDER, LOREM, RUTRUM }

final categoryValues = EnumValues({
  "elementum": Category.ELEMENTUM,
  "ipsum": Category.IPSUM,
  "jsonplaceholder": Category.JSONPLACEHOLDER,
  "lorem": Category.LOREM,
  "rutrum": Category.RUTRUM
});

enum Status { PUBLISHED }

final statusValues = EnumValues({"published": Status.PUBLISHED});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}