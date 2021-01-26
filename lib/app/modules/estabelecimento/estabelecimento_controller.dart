import 'package:cuidape_curso/app/models/fornecedor_model.dart';
import 'package:cuidape_curso/app/services/fornecedor_service.dart';
import 'package:mobx/mobx.dart';

part 'estabelecimento_controller.g.dart';

class EstabelecimentoController = _EstabelecimentoControllerBase
    with _$EstabelecimentoController;

abstract class _EstabelecimentoControllerBase with Store {
  final FornecedorService _fornecedorService;

  @observable
  ObservableFuture<FornecedorModel> fornecedorFuture;
  _EstabelecimentoControllerBase(this._fornecedorService);
  @action
  void initPage(id) {
    fornecedorFuture = ObservableFuture(_fornecedorService.buscaPorId(id));
  }
}
