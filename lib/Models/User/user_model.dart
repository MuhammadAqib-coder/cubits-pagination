// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';
import 'package:cubit_task/Models/User/support.dart';
import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';
part 'user_model.g.dart';

UserModel? userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

@JsonSerializable(explicitToJson: true)
class UserModel {
  UserModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<Datum?>? data;
  final Support? support;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //       page: json["page"],
  //       perPage: json["per_page"],
  //       total: json["total"],
  //       totalPages: json["total_pages"],
  //       data: json["data"] == null
  //           ? []
  //           : json["data"] == null
  //               ? []
  //               : List<Datum?>.from(
  //                   json["data"]!.map((x) => Datum.fromJson(x))),
  //       support: Support.fromJson(json['support']),
  //     );

  // Map<String, dynamic> toJson() => {
  //       "page": page,
  //       "per_page": perPage,
  //       "total": total,
  //       "total_pages": totalPages,
  //       "data": data == null
  //           ? []
  //           : data == null
  //               ? []
  //               : List<dynamic>.from(data!.map((x) => x!.toJson())),
  //       "support": support,
  //     };
}
