import 'package:cuidape_curso/app/models/categoria_models.dart';
import 'package:cuidape_curso/app/repository/categorias_repository.dart';

class CategoriaService {
  final CategoriasRepository _repository;
  CategoriaService(this._repository);

  Future<List<CategoriaModel>> buscarCategorias() {
    return _repository.buscarCategoria();
  }
}
