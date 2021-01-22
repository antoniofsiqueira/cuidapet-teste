import 'package:json_annotation/json_annotation.dart';

part 'categoria_models.g.dart';

@JsonSerializable()
class CategoriaModel {
  int id;
  String nome;
  String tipo;
  CategoriaModel({
    this.id,
    this.nome,
    this.tipo,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriaModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriaModelToJson(this);
}
