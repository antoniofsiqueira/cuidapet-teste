// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioModel _$UsuarioModelFromJson(Map<String, dynamic> json) {
  return UsuarioModel(
    email: json['email'] as String,
    tipoCadastro: json['tipoCadastro'] as String,
    imagemAvatar: json['imagemAvatar'] as String,
  );
}

Map<String, dynamic> _$UsuarioModelToJson(UsuarioModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'tipoCadastro': instance.tipoCadastro,
      'imagemAvatar': instance.imagemAvatar,
    };
