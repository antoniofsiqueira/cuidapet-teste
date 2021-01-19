import 'package:cuidape_curso/app/modules/login/cadastro/cadastro_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidape_curso/app/modules/login/cadastro/cadastro_page.dart';

class CadastroModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CadastroController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => CadastroPage()),
      ];

  static Inject get to => Inject<CadastroModule>.of();
}
