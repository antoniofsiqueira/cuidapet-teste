import 'package:cuidape_curso/app/core/dio/custom_dio.dart';
import 'package:cuidape_curso/app/viewsModels/agendamento_vm.dart';

class AgendamentoRepository {
  Future<void> salvarAgendamento(AgendamentoVM agendamento) async {
    await CustomDio.authInstance.post('/agendamento/agendar', data: {
      'data_agendamento': agendamento.dataHora.toIso8601String(),
      'fornecedor_id': agendamento.fornecedor,
      'servicos': agendamento.servicos.map<int>((s) => s.id).toList(),
      'nome': agendamento.nomeReserva,
      'nome_pet': agendamento.nomePet
    });
  }
}
