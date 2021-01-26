import 'package:cuidape_curso/app/models/categoria_models.dart';
import 'package:cuidape_curso/app/models/fornecedor_busca_model.dart';
import 'package:cuidape_curso/app/services/fornecedor_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidape_curso/app/models/endereco_model.dart';
import 'package:cuidape_curso/app/repository/share_prefs_repository.dart';
import 'package:cuidape_curso/app/services/categoria_service.dart';
import 'package:cuidape_curso/app/services/endereco_service.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EnderecoService _enderecoService;
  final CategoriaService _categoriaService;
  final FornecedorService _fornecedorService;
  final TextEditingController filtroNomeController = TextEditingController();

  @observable
  EnderecoModel enderecoSelecionado;

  @observable
  ObservableFuture<List<CategoriaModel>> categoriasFuture;

  @observable
  int paginaSelecionada = 0;

  @observable
  ObservableFuture<List<FornecedorBuscaModel>> estabelicimentosFuture;

  List<FornecedorBuscaModel> estabelicimentosOriginais;

  @observable
  int categoriaSelecionada;

  _HomeControllerBase(
    this._enderecoService,
    this._categoriaService,
    this._fornecedorService,
  );

  @action
  void alterarPaginaSelecionada(int pagina) => paginaSelecionada = pagina;

  @action
  Future<void> initPage() async {
    await temEnderecoCadastrado();
    await recuperarEnderecoSelecionado();
    buscarCategorias();
    await buscarEstabelecimentos();
  }

  @action
  void buscarCategorias() {
    categoriasFuture = ObservableFuture(_categoriaService.buscarCategorias());
  }

  @action
  Future<void> buscarEstabelecimentos() async {
    categoriaSelecionada = null;
    filtroNomeController.text = '';
    estabelicimentosFuture = ObservableFuture(
        _fornecedorService.buscarFornecedoresProximos(enderecoSelecionado));
    estabelicimentosOriginais = await estabelicimentosFuture;
  }

  @action
  void filtrarPorCategoria(int id) {
    //var fornecedores = estabelicimentosOriginais;
    if (categoriaSelecionada == id) {
      categoriaSelecionada = null;
    } else {
      categoriaSelecionada = id;
      _filtrarEstabelecimentos();
    }
  }

  @action
  void filtrarEstabelecimentoPorNome() {
    _filtrarEstabelecimentos();
  }

  @action
  void _filtrarEstabelecimentos() {
    var fornecedores = estabelicimentosOriginais;
    if (categoriaSelecionada != null) {
      fornecedores = fornecedores
          .where((e) => e.categoria.id == categoriaSelecionada)
          .toList();
    }

    if (filtroNomeController.text.isNotEmpty) {
      fornecedores = fornecedores
          .where((e) => e.nome
              .toLowerCase()
              .contains(filtroNomeController.text.toLowerCase()))
          .toList();
    }
    estabelicimentosFuture = ObservableFuture(Future.value(fornecedores));
  }

  @action
  Future<void> recuperarEnderecoSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    enderecoSelecionado = await prefs.enderecoSelecionado;
  }

  @action
  Future<void> temEnderecoCadastrado() async {
    var temEndereco = await _enderecoService.existeEnderecoCadastrado();
    if (!temEndereco) {
      await Modular.to.pushNamed('/home/enderecos');
    }
  }
}
