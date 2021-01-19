import 'package:cuidape_curso/app/models/endereco_model.dart';
import 'package:cuidape_curso/app/services/endereco_service.dart';
import 'package:cuidape_curso/app/shared/componnent/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'detalhe_controller.g.dart';

class DetalheController = _DetalheControllerBase with _$DetalheController;

abstract class _DetalheControllerBase with Store {
  final EnderecoService _service;
  TextEditingController complementoTextController = TextEditingController();

  _DetalheControllerBase(this._service);

  Future<void> salvarEndereco(EnderecoModel model) async {
    try {
      Loader.show();
      model.complemento = complementoTextController.text;
      await _service.salvarEndereco(model);
      Loader.hide();
      Modular.to.pop();
    } catch (e) {
      Loader.hide();
      print(e);
      Get.snackbar('Erro', 'Erro ao salvar endereço');
    }
  }
}
