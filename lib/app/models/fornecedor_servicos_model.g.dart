// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_servicos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FornecedorServicoModel _$FornecedorServicoModelFromJson(
    Map<String, dynamic> json) {
  return FornecedorServicoModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    valor: (json['valor'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$FornecedorServicoModelToJson(
        FornecedorServicoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'valor': instance.valor,
    };
