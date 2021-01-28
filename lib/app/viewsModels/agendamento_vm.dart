import 'package:flutter/foundation.dart';

import 'package:cuidape_curso/app/models/fornecedor_servicos_model.dart';

class AgendamentoVM {
  int fornecedor;
  DateTime dataHora;
  String nomeReserva;
  String nomePet;
  List<FornecedorServicoModel> servicos;
  AgendamentoVM({
    @required this.fornecedor,
    @required this.dataHora,
    @required this.nomeReserva,
    @required this.nomePet,
    @required this.servicos,
  });
}
