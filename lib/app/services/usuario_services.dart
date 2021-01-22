import 'package:cuidape_curso/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidape_curso/app/models/access_token_model.dart';
import 'package:cuidape_curso/app/repository/facebook_repository.dart';
import 'package:cuidape_curso/app/repository/security_storage_repository.dart';
import 'package:cuidape_curso/app/repository/share_prefs_repository.dart';
import 'package:cuidape_curso/app/repository/usuario_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UsuarioService {
  final UsuarioRepository _repository;
  UsuarioService(this._repository);

  Future<void> login(bool facebookLogin,
      {String email, String password}) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final fireAuth = FirebaseAuth.instance;
      AccessTokenModel accessTokenModel;

      if (!facebookLogin) {
        accessTokenModel = await _repository.login(email,
            password: password, facebookLogin: facebookLogin, avatar: '');
        await fireAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        var facebookModel = await FacebookRepository().login();
        if (facebookModel != null) {
          accessTokenModel = await _repository.login(facebookModel.email,
              password: password,
              facebookLogin: facebookLogin,
              avatar: facebookModel.picture);
          final facebookCredencial = FacebookAuthProvider.getCredential(
              accessToken: facebookModel.token);
          fireAuth.signInWithCredential(facebookCredencial);
        } else {
          throw AcessoNegadoException('Acesso Negado');
        }
      }

      await prefs.registerAccessToken(accessTokenModel.accessToken);

      final confirmModel = await _repository.confirmLogin();
      await prefs.registerAccessToken(confirmModel.accessToken);
      SecurityStorageRepository()
          .registerRefreshToken(confirmModel.refreshToken);
      final dadosUsuario = await _repository.recuperarDadosUsuarioLogado();
      await prefs.registerDadosUsuario(dadosUsuario);
    } on PlatformException catch (e) {
      print('Erro ao fazer login no Firebase $e');
      rethrow;
    } on DioError catch (e) {
      if (e.response.statusCode == 403) {
        throw AcessoNegadoException(e.response.data['message'], exception: e);
      } else {
        rethrow;
      }
    } catch (e) {
      print('Erro ao fazer login $e');
      rethrow;
    }
  }

  Future<void> cadastrarUsuario(String email, String senha) async {
    await _repository.cadastrarUsuario(email, senha);
    var fireAuth = FirebaseAuth.instance;
    fireAuth.createUserWithEmailAndPassword(email: email, password: senha);
  }
}
