import 'package:cuidape_curso/app/core/database/connection.dart';
import 'package:cuidape_curso/app/models/endereco_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoRepository {
  Future<List<EnderecoModel>> buscarEnderecos() async {
    final conn = await Connection().instance;
    var result = await conn.rawQuery('select * from endereco');
    return result.map((e) => EnderecoModel.fromMap(e)).toList();
  }

  Future<void> salvarEndereco(EnderecoModel model) async {
    final conn = await Connection().instance;
    await conn.rawInsert('Insert into endereco values(?,?,?,?,?)', [
      null,
      model.endereco,
      model.latitude,
      model.longitude,
      model.complemento
    ]);
  }

  Future<void> limparEnderecosCadastros() async {
    final conn = await Connection().instance;
    await conn.rawDelete('delete from endereco');
  }

  Future<List<Prediction>> buscaEnderecoGooglePlaces(String endereco) async {
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['googleApiKey']);
    var response = await places.autocomplete(endereco, language: 'pt');
    return response.predictions;
  }

  Future<PlacesDetailsResponse> recuperarDetalhesEnderecoGooglePlaces(
      String placeId) {
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['googleApiKey']);
    return places.getDetailsByPlaceId(placeId);
  }
}
