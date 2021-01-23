import 'package:cuidape_curso/app/models/endereco_model.dart';
import 'package:cuidape_curso/app/repository/endereco_repository.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoService {
  final EnderecoRepository _repository;
  EnderecoService(this._repository);

  Future<bool> existeEnderecoCadastrado() async {
    var listaEnderecos = await _repository.buscarEnderecos();
    return listaEnderecos.isNotEmpty;
  }

  Future<List<Prediction>> buscarEnderecoGooglePlaces(String endereco) async {
    return await _repository.buscarEnderecoGooglePlaces(endereco);
  }

  Future<void> salvarEndereco(EnderecoModel endereco) async {
    await _repository.salvarEndereco(endereco);
  }

  Future<List<EnderecoModel>> buscarEnderecosCadastrados() {
    return _repository.buscarEnderecos();
  }

  Future<PlacesDetailsResponse> buscarDetalheEnderecoGooglePlaces(
      String placeId) {
    return _repository.recuperarDetalhesEnderecoGooglePlaces(placeId);
  }
}
