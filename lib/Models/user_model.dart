// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel? userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: json["data"] == null
            ? []
            : json["data"] == null
                ? []
                : List<Datum?>.from(
                    json["data"]!.map((x) => Datum.fromJson(x))),
        support: Support.fromJson(json['support']),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": data == null
            ? []
            : data == null
                ? []
                : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "support": support,
      };
}

class Datum {
  Datum({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

class Support {
  Support({
    this.url,
    this.text,
  });

  final String? url;
  final String? text;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
