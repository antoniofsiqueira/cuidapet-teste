// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  final _$usuarioLogadoAtom = Atom(name: '_AuthStoreBase.usuarioLogado');

  @override
  UsuarioModel get usuarioLogado {
    _$usuarioLogadoAtom.reportRead();
    return super.usuarioLogado;
  }

  @override
  set usuarioLogado(UsuarioModel value) {
    _$usuarioLogadoAtom.reportWrite(value, super.usuarioLogado, () {
      super.usuarioLogado = value;
    });
  }

  final _$loadUsuarioAsyncAction = AsyncAction('_AuthStoreBase.loadUsuario');

  @override
  Future<void> loadUsuario() {
    return _$loadUsuarioAsyncAction.run(() => super.loadUsuario());
  }

  final _$isLoggedAsyncAction = AsyncAction('_AuthStoreBase.isLogged');

  @override
  Future<bool> isLogged() {
    return _$isLoggedAsyncAction.run(() => super.isLogged());
  }

  @override
  String toString() {
    return '''
usuarioLogado: ${usuarioLogado}
    ''';
  }
}
