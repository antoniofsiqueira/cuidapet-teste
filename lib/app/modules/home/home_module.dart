import 'package:cuidape_curso/app/modules/home/enderecos/enderecos_module.dart';
import 'package:cuidape_curso/app/modules/home/home_controller.dart';
import 'package:cuidape_curso/app/repository/categorias_repository.dart';
import 'package:cuidape_curso/app/services/categoria_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidape_curso/app/modules/home/home_page.dart';

//import 'enderecos/enderecos_module.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CategoriasRepository()),
        Bind((i) => CategoriaService(i.get())),
        Bind((i) => HomeController(i.get(), i.get(), i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/enderecos', module: EnderecosModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
