import 'package:json_annotation/json_annotation.dart';
part 'support.g.dart';

@JsonSerializable()
class Support {
  Support({
    this.url,
    this.text,
  });

  final String? url;
  final String? text;

  factory Support.fromJson(Map<String, dynamic> json) =>
      _$SupportFromJson(json);

  Map<String, dynamic> toJson() => _$SupportToJson(this);

  // factory Support.fromJson(Map<String, dynamic> json) => Support(
  //       url: json["url"],
  //       text: json["text"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "url": url,
  //       "text": text,
  //     };
}
