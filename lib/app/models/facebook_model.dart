import 'package:json_annotation/json_annotation.dart';

part 'facebook_model.g.dart';

@JsonSerializable()
class FacebookModel {
  @JsonKey(ignore: true)
  String token;

  String email;
  @JsonKey(name: 'picture', fromJson: _pictureFromJson)
  String picture;

  FacebookModel({
    this.email,
    this.picture,
  });

  factory FacebookModel.fromJson(Map<String, dynamic> json) =>
      _$FacebookModelFromJson(json);
  Map<String, dynamic> toJson() => _$FacebookModelToJson(this);

  static String _pictureFromJson(jsonData) {
    return jsonData['data']['url'];
  }
}
