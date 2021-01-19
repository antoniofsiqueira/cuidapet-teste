import 'package:cuidape_curso/app/services/usuario_services.dart';
import 'package:cuidape_curso/app/shared/componnent/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioService _service;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  @observable
  bool esconderSenha = true;

  @observable
  bool esconderConfirmaSenha = true;

  _CadastroControllerBase(this._service);

  @action
  void mostraSenha() => esconderSenha = !esconderSenha;

  @action
  void mostraConfirmaSenha() => esconderConfirmaSenha = !esconderConfirmaSenha;

  @action
  Future<void> cadasrtarUsuario() async {
    if (formKey.currentState.validate()) {
      Loader.show();
      try {
        await _service.cadastrarUsuario(
            loginController.text, senhaController.text);
        Loader.hide();
        Modular.to.pop();
      } catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Erro ao cadastrar usuário');
      }
    }
  }
}
