// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroController on _CadastroControllerBase, Store {
  final _$esconderSenhaAtom =
      Atom(name: '_CadastroControllerBase.esconderSenha');

  @override
  bool get esconderSenha {
    _$esconderSenhaAtom.reportRead();
    return super.esconderSenha;
  }

  @override
  set esconderSenha(bool value) {
    _$esconderSenhaAtom.reportWrite(value, super.esconderSenha, () {
      super.esconderSenha = value;
    });
  }

  final _$esconderConfirmaSenhaAtom =
      Atom(name: '_CadastroControllerBase.esconderConfirmaSenha');

  @override
  bool get esconderConfirmaSenha {
    _$esconderConfirmaSenhaAtom.reportRead();
    return super.esconderConfirmaSenha;
  }

  @override
  set esconderConfirmaSenha(bool value) {
    _$esconderConfirmaSenhaAtom.reportWrite(value, super.esconderConfirmaSenha,
        () {
      super.esconderConfirmaSenha = value;
    });
  }

  final _$cadasrtarUsuarioAsyncAction =
      AsyncAction('_CadastroControllerBase.cadasrtarUsuario');

  @override
  Future<void> cadasrtarUsuario() {
    return _$cadasrtarUsuarioAsyncAction.run(() => super.cadasrtarUsuario());
  }

  final _$_CadastroControllerBaseActionController =
      ActionController(name: '_CadastroControllerBase');

  @override
  void mostraSenha() {
    final _$actionInfo = _$_CadastroControllerBaseActionController.startAction(
        name: '_CadastroControllerBase.mostraSenha');
    try {
      return super.mostraSenha();
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void mostraConfirmaSenha() {
    final _$actionInfo = _$_CadastroControllerBaseActionController.startAction(
        name: '_CadastroControllerBase.mostraConfirmaSenha');
    try {
      return super.mostraConfirmaSenha();
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
esconderSenha: ${esconderSenha},
esconderConfirmaSenha: ${esconderConfirmaSenha}
    ''';
  }
}
