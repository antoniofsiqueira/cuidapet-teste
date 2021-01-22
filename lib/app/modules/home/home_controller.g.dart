// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$enderecoModelAtom = Atom(name: '_HomeControllerBase.enderecoModel');

  @override
  EnderecoModel get enderecoModel {
    _$enderecoModelAtom.reportRead();
    return super.enderecoModel;
  }

  @override
  set enderecoModel(EnderecoModel value) {
    _$enderecoModelAtom.reportWrite(value, super.enderecoModel, () {
      super.enderecoModel = value;
    });
  }

  final _$categoriasFutureAtom =
      Atom(name: '_HomeControllerBase.categoriasFuture');

  @override
  ObservableFuture<List<CategoriaModel>> get categoriasFuture {
    _$categoriasFutureAtom.reportRead();
    return super.categoriasFuture;
  }

  @override
  set categoriasFuture(ObservableFuture<List<CategoriaModel>> value) {
    _$categoriasFutureAtom.reportWrite(value, super.categoriasFuture, () {
      super.categoriasFuture = value;
    });
  }

  final _$paginaSelecionadaAtom =
      Atom(name: '_HomeControllerBase.paginaSelecionada');

  @override
  int get paginaSelecionada {
    _$paginaSelecionadaAtom.reportRead();
    return super.paginaSelecionada;
  }

  @override
  set paginaSelecionada(int value) {
    _$paginaSelecionadaAtom.reportWrite(value, super.paginaSelecionada, () {
      super.paginaSelecionada = value;
    });
  }

  final _$initPageAsyncAction = AsyncAction('_HomeControllerBase.initPage');

  @override
  Future<void> initPage() {
    return _$initPageAsyncAction.run(() => super.initPage());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void alterarPaginaSelecionada(int pagina) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.alterarPaginaSelecionada');
    try {
      return super.alterarPaginaSelecionada(pagina);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buscarCategorias() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.buscarCategorias');
    try {
      return super.buscarCategorias();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enderecoModel: ${enderecoModel},
categoriasFuture: ${categoriasFuture},
paginaSelecionada: ${paginaSelecionada}
    ''';
  }
}
