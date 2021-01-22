import 'package:cuidape_curso/app/core/dio/custom_dio.dart';
import 'package:cuidape_curso/app/models/fornecedor_busca_model.dart';

class FornecedorRepository {
  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(
      double lat, double lng) {
    return CustomDio.authInstance
        .get('/fornecedores', queryParameters: {'lat': lat, 'long': lng}).then(
      (res) => res.data
          .map<FornecedorBuscaModel>((f) => FornecedorBuscaModel.fromJson(f))
          .toList(),
    );
  }
}
