import 'package:cuidape_curso/app/repository/agendamento_repository.dart';
import 'package:cuidape_curso/app/viewsModels/agendamento_vm.dart';

class AgendamentoService {
  final AgendamentoRepository _repository;
  AgendamentoService(this._repository);
  Future<void> salvarAgendamento(AgendamentoVM agendamento) async {
    await _repository.salvarAgendamento(agendamento);
  }
}
