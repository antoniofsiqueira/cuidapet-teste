import 'package:cuidape_curso/app/models/endereco_model.dart';
import 'package:cuidape_curso/app/services/endereco_service.dart';
import 'package:cuidape_curso/app/shared/componnent/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

part 'enderecos_controller.g.dart';

class EnderecosController = _EnderecosControllerBase with _$EnderecosController;

abstract class _EnderecosControllerBase with Store {
  final EnderecoService _enderecoService;
  TextEditingController enderecoTextController = TextEditingController();

  _EnderecosControllerBase(this._enderecoService);

  @observable
  ObservableFuture<List<EnderecoModel>> enderecosFuture;

  Future<List<Prediction>> buscaEnderecos(String endereco) {
    return _enderecoService.buscaEnderecoGooglePlaces(endereco);
  }

  Future<void> minhaLocalizacao() async {
    Loader.show();
    var geolocator = Geolocator();
    // position = await Geolocator().getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
    var position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var placemark = await geolocator.placemarkFromPosition(position);
    var place = placemark[0];
    var endereco = '${place.thoroughfare} ${place.subThoroughfare}';
    var enderecoModel = EnderecoModel(
        id: null,
        endereco: endereco,
        latitude: position.latitude,
        longitude: position.longitude,
        complemento: null);
    Loader.hide();
    await Modular.link.pushNamed('/detalhe', arguments: enderecoModel);
    buscarEnderecosCadastrados();
  }

  void buscarEnderecosCadastrados() {
    enderecosFuture =
        ObservableFuture(_enderecoService.buscarEnderecosCadastrados());
  }
}
