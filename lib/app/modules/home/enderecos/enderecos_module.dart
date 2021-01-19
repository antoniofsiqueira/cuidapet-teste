import 'package:cuidape_curso/app/modules/home/enderecos/detalhe/detalhe_controller.dart';
import 'package:cuidape_curso/app/modules/home/enderecos/enderecos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidape_curso/app/modules/home/enderecos/enderecos_page.dart';

import 'detalhe/detalhe_page.dart';

class EnderecosModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DetalheController(i.get())),
        Bind((i) => EnderecosController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => EnderecosPage()),
        ModularRouter('/detalhe',
            child: (_, args) => DetalhePage(
                  enderecoModel: args.data,
                )),
      ];

  static Inject get to => Inject<EnderecosModule>.of();
}
