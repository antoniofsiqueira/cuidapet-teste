// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enderecos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EnderecosController on _EnderecosControllerBase, Store {
  final _$enderecosFutureAtom =
      Atom(name: '_EnderecosControllerBase.enderecosFuture');

  @override
  ObservableFuture<List<EnderecoModel>> get enderecosFuture {
    _$enderecosFutureAtom.reportRead();
    return super.enderecosFuture;
  }

  @override
  set enderecosFuture(ObservableFuture<List<EnderecoModel>> value) {
    _$enderecosFutureAtom.reportWrite(value, super.enderecosFuture, () {
      super.enderecosFuture = value;
    });
  }

  @override
  String toString() {
    return '''
enderecosFuture: ${enderecosFuture}
    ''';
  }
}
