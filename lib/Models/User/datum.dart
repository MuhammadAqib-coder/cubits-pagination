import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
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

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  // factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  //       id: json["id"],
  //       email: json["email"],
  //       firstName: json["first_name"],
  //       lastName: json["last_name"],
  //       avatar: json["avatar"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "email": email,
  //       "first_name": firstName,
  //       "last_name": lastName,
  //       "avatar": avatar,
  //     };
}
