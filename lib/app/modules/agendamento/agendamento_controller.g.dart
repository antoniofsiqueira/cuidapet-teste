// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AgendamentoController on _AgendamentoControllerBase, Store {
  final _$dataSelecionadaAtom =
      Atom(name: '_AgendamentoControllerBase.dataSelecionada');

  @override
  DateTime get dataSelecionada {
    _$dataSelecionadaAtom.reportRead();
    return super.dataSelecionada;
  }

  @override
  set dataSelecionada(DateTime value) {
    _$dataSelecionadaAtom.reportWrite(value, super.dataSelecionada, () {
      super.dataSelecionada = value;
    });
  }

  final _$horarioSelecionadoAtom =
      Atom(name: '_AgendamentoControllerBase.horarioSelecionado');

  @override
  TimeOfDay get horarioSelecionado {
    _$horarioSelecionadoAtom.reportRead();
    return super.horarioSelecionado;
  }

  @override
  set horarioSelecionado(TimeOfDay value) {
    _$horarioSelecionadoAtom.reportWrite(value, super.horarioSelecionado, () {
      super.horarioSelecionado = value;
    });
  }

  final _$salvarAgendamentoAsyncAction =
      AsyncAction('_AgendamentoControllerBase.salvarAgendamento');

  @override
  Future<void> salvarAgendamento(
      int estabelecimento, List<FornecedorServicoModel> servicos) {
    return _$salvarAgendamentoAsyncAction
        .run(() => super.salvarAgendamento(estabelecimento, servicos));
  }

  final _$_AgendamentoControllerBaseActionController =
      ActionController(name: '_AgendamentoControllerBase');

  @override
  void alterarData(DateTime data) {
    final _$actionInfo = _$_AgendamentoControllerBaseActionController
        .startAction(name: '_AgendamentoControllerBase.alterarData');
    try {
      return super.alterarData(data);
    } finally {
      _$_AgendamentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void alterarHorario(TimeOfDay horario) {
    final _$actionInfo = _$_AgendamentoControllerBaseActionController
        .startAction(name: '_AgendamentoControllerBase.alterarHorario');
    try {
      return super.alterarHorario(horario);
    } finally {
      _$_AgendamentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataSelecionada: ${dataSelecionada},
horarioSelecionado: ${horarioSelecionado}
    ''';
  }
}
