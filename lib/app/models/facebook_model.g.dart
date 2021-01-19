// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacebookModel _$FacebookModelFromJson(Map<String, dynamic> json) {
  return FacebookModel(
    email: json['email'] as String,
    picture: FacebookModel._pictureFromJson(json['picture']),
  );
}

Map<String, dynamic> _$FacebookModelToJson(FacebookModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'picture': instance.picture,
    };
