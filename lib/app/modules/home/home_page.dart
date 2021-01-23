import 'package:cuidape_curso/app/models/categoria_models.dart';
import 'package:cuidape_curso/app/models/fornecedor_busca_model.dart';
import 'package:cuidape_curso/app/modules/home/components/estabelecimento_card.dart';
import 'package:cuidape_curso/app/modules/home/components/estabelecimento_item_lista.dart';
import 'package:cuidape_curso/app/modules/home/components/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  HomeAppBar appBar;
  final Map<String, IconData> categoriasIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory
  };
  final PageController _estabelecimentoPageController =
      PageController(initialPage: 0);

  _HomePageState() {
    appBar = HomeAppBar(controller);
  }
  @override
  void initState() {
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[100],
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          //height: 500,
          height: ScreenUtil.screenHeightDp -
              (appBar.preferredSize.height + ScreenUtil.statusBarHeight),
          child: Column(
            children: <Widget>[
              _buildEndereco(),
              _buildCategorias(),
              Expanded(
                child: _buildEstabelicimentos(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildEndereco() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text('Estabelicimentos proximos de:'),
          Observer(builder: (_) {
            return Text(
              controller.enderecoSelecionado?.endereco ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            );
          }),
        ],
      ),
    );
  }

  Observer _buildCategorias() {
    return Observer(builder: (_) {
      return FutureBuilder<List<CategoriaModel>>(
          future: controller.categoriasFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
                break;
              case ConnectionState.waiting:

              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao buscar categorias'));
                }
                if (snapshot.hasData) {
                  var cats = snapshot.data;
                  return Container(
                    height: 120,
                    //color: Colors.red,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: cats.length,
                      itemBuilder: (context, index) {
                        var cat = cats[index];
                        return Container(
                          margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                child: Icon(
                                  categoriasIcons[cat.tipo],
                                  size: 30,
                                  color: Colors.black,
                                ),
                                radius: 30,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(cat.nome),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
                break;
              default:
                return Container();
            }
          });
    });
  }

  Column _buildEstabelicimentos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Observer(builder: (_) {
            return Row(
              children: [
                Text('Estabelicimentos'),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _estabelecimentoPageController.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    child: Icon(Icons.view_headline,
                        color: controller.paginaSelecionada == 0
                            ? Colors.black
                            : Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _estabelecimentoPageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    child: Icon(Icons.view_comfy,
                        color: controller.paginaSelecionada == 1
                            ? Colors.black
                            : Colors.grey),
                  ),
                ),
              ],
            );
          }),
        ),
        Expanded(
            child: PageView(
          controller: _estabelecimentoPageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (pagina) =>
              controller.alterarPaginaSelecionada(pagina),
          children: [
            _buildEstabelicimentoLista(),
            _buildEstabelicimentoGrid(),
          ],
        ))
      ],
    );
  }

  Widget _buildEstabelicimentoLista() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorBuscaModel>>(
        future: controller.estabelicimentosFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:

            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao buscar categorias'));
              }
              if (snapshot.hasData) {
                var fornecs = snapshot.data;
                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: fornecs.length,
                  itemBuilder: (context, index) {
                    var fornec = fornecs[index];
                    return EstabelecimentoItemLista(fornec);
                  },
                  separatorBuilder: (_, index) => Divider(
                    color: Colors.transparent,
                  ),
                );
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }

  Widget _buildEstabelicimentoGrid() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorBuscaModel>>(
        future: controller.estabelicimentosFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:

            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao buscar categorias'));
              }
              if (snapshot.hasData) {
                var fornecs = snapshot.data;
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: fornecs.length,
                  itemBuilder: (context, index) {
                    return EstabelecimentoCard(fornecs[index]);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                  ),
                );
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }
}
