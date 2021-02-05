import 'dart:io';

import 'package:cuidape_curso/app/core/dio/custom_dio.dart';
import 'package:cuidape_curso/app/models/access_token_model.dart';
import 'package:cuidape_curso/app/models/confirm_loggin_model.dart';
import 'package:cuidape_curso/app/models/usuario_model.dart';
import 'package:cuidape_curso/app/repository/share_prefs_repository.dart';

class UsuarioRepository {
  Future<AccessTokenModel> login(String email,
      {String password, bool facebookLogin = false, String avatar = ''}) async {
    return CustomDio.instance.post('/login', data: {
      'login': email,
      'senha': password,
      'facebookLogin': facebookLogin,
      'avatar': avatar
    }).then((res) => AccessTokenModel.fromJson(res.data));
  }

  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;
    final deviceId = prefs.deviceId;

    return CustomDio.authInstance.patch('/login/confirmar', data: {
      'ios_token': Platform.isIOS ? deviceId : null,
      'android_token': Platform.isAndroid ? deviceId : null
    }).then((res) => ConfirmLoginModel.fromJson(res.data));
  }

  Future<UsuarioModel> recuperarDadosUsuarioLogado() {
    return CustomDio.authInstance
        .get('/usuario')
        .then((res) => UsuarioModel.fromJson(res.data));
  }

  Future<void> cadastrarUsuario(String email, String senha) async {
    await CustomDio.instance
        .post('/login/cadastrar', data: {'email': email, 'senha': senha});
  }

  Future<UsuarioModel> atualizarImagemPerfil(String urlImagem) {
    return CustomDio.authInstance.put('/usuario/avatar', data: {
      'url_avatar': urlImagem
    }).then((res) => UsuarioModel.fromJson(res.data));
  }
}
