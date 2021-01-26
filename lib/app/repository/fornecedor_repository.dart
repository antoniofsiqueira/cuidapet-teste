import 'package:cuidape_curso/app/core/dio/custom_dio.dart';
import 'package:cuidape_curso/app/models/fornecedor_busca_model.dart';
import 'package:cuidape_curso/app/models/fornecedor_model.dart';
import 'package:cuidape_curso/app/models/fornecedor_servicos_model.dart';

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

  Future<FornecedorModel> buscaPorId(int id) {
    return CustomDio.authInstance
        .get('/fornecedores/$id')
        .then((res) => FornecedorModel.fromJson(res.data));
  }

  Future<List<FornecedorServicoModel>> buscarServicosFornecedor(
      int fornecedor) {
    return CustomDio.authInstance
        .get('/fornecedores/servicos/$fornecedor')
        .then((res) => res.data
            .map<FornecedorServicoModel>(
                (f) => FornecedorServicoModel.fromJson(f))
            .toList());
  }
}
