import 'package:cuidape_curso/app/core/dio/custom_dio.dart';
import 'package:cuidape_curso/app/models/categoria_models.dart';

class CategoriasRepository {
  Future<List<CategoriaModel>> buscarCategoria() {
    return CustomDio.authInstance.get('/categorias').then((res) => res.data
        .map<CategoriaModel>((c) => CategoriaModel.fromJson(c))
        .toList());
  }
}
