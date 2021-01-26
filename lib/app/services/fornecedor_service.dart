import 'package:cuidape_curso/app/models/endereco_model.dart';
import 'package:cuidape_curso/app/models/fornecedor_busca_model.dart';
import 'package:cuidape_curso/app/models/fornecedor_model.dart';
import 'package:cuidape_curso/app/repository/fornecedor_repository.dart';

class FornecedorService {
  final FornecedorRepository _repository;
  FornecedorService(this._repository);

  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(
      EnderecoModel endereco) {
    return _repository.buscarFornecedoresProximos(
        endereco.latitude, endereco.longitude);
  }

  Future<FornecedorModel> buscaPorId(int id) {
    return _repository.buscaPorId(id);
  }
}
