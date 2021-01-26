import 'package:cuidape_curso/app/modules/estabelecimento/estabelecimento_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidape_curso/app/modules/estabelecimento/estabelecimento_page.dart';

class EstabelecimentoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EstabelecimentoController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/:id',
            child: (_, args) => EstabelecimentoPage(
                  estabelecimentoId: int.parse(args.params['id']),
                )),
      ];

  static Inject get to => Inject<EstabelecimentoModule>.of();
}
