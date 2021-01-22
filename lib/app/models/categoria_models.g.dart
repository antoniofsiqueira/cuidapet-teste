// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriaModel _$CategoriaModelFromJson(Map<String, dynamic> json) {
  return CategoriaModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    tipo: json['tipo'] as String,
  );
}

Map<String, dynamic> _$CategoriaModelToJson(CategoriaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'tipo': instance.tipo,
    };
