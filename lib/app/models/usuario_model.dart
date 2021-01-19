import 'package:json_annotation/json_annotation.dart';

part 'usuario_model.g.dart';

@JsonSerializable()
class UsuarioModel {
  String email;
  String tipoCadastro;
  String imagemAvatar;

  UsuarioModel({
    this.email,
    this.tipoCadastro,
    this.imagemAvatar,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) =>
      _$UsuarioModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioModelToJson(this);
}
