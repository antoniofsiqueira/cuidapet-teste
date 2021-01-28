import 'package:cuidape_curso/app/app_controller.dart';
import 'package:cuidape_curso/app/core/database/connection_adm.dart';
import 'package:cuidape_curso/app/modules/home/home_module.dart';
import 'package:cuidape_curso/app/modules/main_page/main_page.dart';
import 'package:cuidape_curso/app/repository/endereco_repository.dart';
import 'package:cuidape_curso/app/repository/usuario_repository.dart';
import 'package:cuidape_curso/app/services/endereco_service.dart';
import 'package:cuidape_curso/app/services/usuario_services.dart';
import 'package:cuidape_curso/app/shared/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidape_curso/app/app_widget.dart';

import 'modules/agendamento/agendamento_module.dart';
import 'modules/estabelecimento/estabelecimento_module.dart';
import 'modules/login/login_module.dart';
import 'repository/agendamento_repository.dart';
import 'repository/fornecedor_repository.dart';
import 'services/agendamento_service.dart';
import 'services/fornecedor_service.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ConnectionADM(), lazy: false),
        Bind((i) => AppController()),
        Bind((i) => UsuarioRepository()),
        Bind((i) => UsuarioService(i.get())),
        Bind((i) => EnderecoRepository()),
        Bind((i) => EnderecoService(i.get())),
        Bind((i) => FornecedorRepository()),
        Bind((i) => FornecedorService(i.get())),
        Bind((i) => AgendamentoRepository()),
        Bind((i) => AgendamentoService(i.get())),
        Bind((i) => AuthStore()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (context, args) => MainPage(),
        ),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
        ModularRouter('/estabelecimento', module: EstabelecimentoModule()),
        ModularRouter('/agendamento', module: AgendamentoModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
