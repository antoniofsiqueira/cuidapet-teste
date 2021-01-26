import 'package:json_annotation/json_annotation.dart';

part 'fornecedor_servicos_model.g.dart';

@JsonSerializable()
class FornecedorServicoModel {
  int id;
  String nome;
  double valor;
  FornecedorServicoModel({
    this.id,
    this.nome,
    this.valor,
  });

  factory FornecedorServicoModel.fromJson(Map<String, dynamic> json) =>
      _$FornecedorServicoModelFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorServicoModelToJson(this);
}
