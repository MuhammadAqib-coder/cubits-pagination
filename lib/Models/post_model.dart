// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class PostModel {
  PostModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  // factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
  //       userId: json["userId"],
  //       id: json["id"],
  //       title: json["title"],
  //       body: json["body"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "userId": userId,
  //       "id": id,
  //       "title": title,
  //       "body": body,
  //     };
}
