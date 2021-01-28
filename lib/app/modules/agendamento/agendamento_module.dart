import 'package:cuidape_curso/app/modules/agendamento/agendamento_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidape_curso/app/modules/agendamento/agendamento_page.dart';

class AgendamentoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AgendamentoController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) {
          var parametros = args.data;
          return AgendamentoPage(
              estabelecimento: parametros['estabelecimentoId'],
              servicos: parametros['servicosSelecionados']);
        }),
      ];

  static Inject get to => Inject<AgendamentoModule>.of();
}
