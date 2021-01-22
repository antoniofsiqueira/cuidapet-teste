// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_busca_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FornecedorBuscaModel _$FornecedorBuscaModelFromJson(Map<String, dynamic> json) {
  return FornecedorBuscaModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    logo: json['logo'] as String,
    distancia: (json['distancia'] as num)?.toDouble(),
    categoria: json['categoria'] == null
        ? null
        : CategoriaModel.fromJson(json['categoria'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FornecedorBuscaModelToJson(
        FornecedorBuscaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'logo': instance.logo,
      'distancia': instance.distancia,
      'categoria': instance.categoria,
    };
