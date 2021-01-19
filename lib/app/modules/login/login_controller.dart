import 'package:cuidape_curso/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidape_curso/app/services/usuario_services.dart';
import 'package:cuidape_curso/app/shared/componnent/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioService _usuarioService;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @observable
  bool obscureText = false;

  _LoginControllerBase(this._usuarioService);

  @action
  void mostraSenhaUsuario() {
    obscureText = !obscureText;
  }

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _usuarioService.login(false,
            email: loginController.text, password: senhaController.text);
        Loader.hide();
        Modular.to.pushReplacementNamed('/');
      } on AcessoNegadoException catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Error', 'Login e senha  inválido');
      } catch (e) {
        print(e);
        Get.snackbar('Erro', 'Erro ao realizar login');
      }
    }
  }

  Future<void> facebookLogin() async {
    try {
      Loader.show();
      await _usuarioService.login(true);
    } on AcessoNegadoException catch (e) {
      Loader.hide();
      print(e);
      Get.snackbar('Error', 'Login e senha  inválido');
    } catch (e) {
      Loader.hide();
      print(e);
      Get.snackbar('Erro', 'Erro ao realizar login');
    }
  }
}
