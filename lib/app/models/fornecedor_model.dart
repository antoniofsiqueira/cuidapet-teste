import 'package:json_annotation/json_annotation.dart';

import 'package:cuidape_curso/app/models/categoria_models.dart';

part 'fornecedor_model.g.dart';

@JsonSerializable()
class FornecedorModel {
  int id;
  String nome;
  String logo;
  String endereco;
  String telefone;
  double latitude;
  double longitude;
  CategoriaModel categoria;
  FornecedorModel({
    this.id,
    this.nome,
    this.logo,
    this.endereco,
    this.telefone,
    this.latitude,
    this.longitude,
    this.categoria,
  });

  factory FornecedorModel.fromJson(Map<String, dynamic> json) =>
      _$FornecedorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorModelToJson(this);
}
