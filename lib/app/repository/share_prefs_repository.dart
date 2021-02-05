import 'dart:convert';

import 'package:cuidape_curso/app/models/endereco_model.dart';
import 'package:cuidape_curso/app/models/usuario_model.dart';
import 'package:cuidape_curso/app/services/endereco_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN/';
  static const _DEVICE_ID = '/_DEVICE_ID/';
  static const _DADOS_USUARIO = '/_DADOS_USUARIO/';
  static const _ENDERECO_SELECIONADO = '/_ENDERECO_SELECIONADO/';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanseRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanseRepository ??= SharedPrefsRepository._();
    return _instanseRepository;
  }

  Future<void> registerAccessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  Future<void> registerDeviceId(String deviceId) async {
    await prefs.setString(_DEVICE_ID, deviceId);
  }

  String get deviceId => prefs.get(_DEVICE_ID);

  Future<void> registerDadosUsuario(UsuarioModel usuario) async {
    await prefs.setString(_DADOS_USUARIO, jsonEncode(usuario));
  }

  UsuarioModel get dadosUsuario {
    if (prefs.containsKey(_DADOS_USUARIO)) {
      return UsuarioModel.fromJson(jsonDecode(prefs.getString(_DADOS_USUARIO)));
    }
    return null;
  }

  Future<void> logout() async {
    await prefs.clear();
    await Modular.get<EnderecoService>().limparEnderecos();
    await Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
  }

  Future<void> registrarEnderecoSelecionado(EnderecoModel endereco) async {
    await prefs.setString(_ENDERECO_SELECIONADO, endereco.toJson());
  }

  Future<EnderecoModel> get enderecoSelecionado async {
    var enderecoJson = await prefs.getString(_ENDERECO_SELECIONADO);
    if (enderecoJson != null) {
      return EnderecoModel.fromJson(enderecoJson);
    }
    return null;
  }
}
