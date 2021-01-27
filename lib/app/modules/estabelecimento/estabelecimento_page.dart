import 'dart:ui';

import 'package:cuidape_curso/app/models/fornecedor_model.dart';
import 'package:cuidape_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'estabelecimento_controller.dart';

class EstabelecimentoPage extends StatefulWidget {
  final int estabelecimentoId;
  const EstabelecimentoPage({Key key, @required this.estabelecimentoId})
      : super(key: key);

  @override
  _EstabelecimentoPageState createState() => _EstabelecimentoPageState();
}

class _EstabelecimentoPageState
    extends ModularState<EstabelecimentoPage, EstabelecimentoController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.initPage(widget.estabelecimentoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Observer(builder: (_) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: controller.servicoSelecionados.isNotEmpty ? 1 : 0,
          child: FloatingActionButton.extended(
            onPressed: () => Modular.to.pushNamed('/agendamento', arguments: {
              'estabelecimentoId': widget.estabelecimentoId,
              'servicosSelecionados': controller.servicoSelecionados
            }),
            label: Text('Fazer Agendamento'),
            icon: Icon(Icons.schedule),
            backgroundColor: ThemeUtils.primaryColor,
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return FutureBuilder<FornecedorModel>(
        future: controller.fornecedorFuture,
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
                return Center(child: Text('Erro na parada aiiiee.'));
              }
              if (snapshot.hasData) {
                var f = snapshot.data;
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 300,
                      pinned: true,
                      backgroundColor: Colors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          f.nome,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        stretchModes: [
                          StretchMode.zoomBackground,
                          StretchMode.fadeTitle
                        ],
                        background: Image.network(
                          f.logo,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Divider(
                          thickness: 1,
                          color: ThemeUtils.primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Informações do Estabelecimento',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        ListTile(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: f.endereco))
                                .then((_) {
                              Get.snackbar('Copia', 'Endereco Copiado');
                            });
                          },
                          leading: Icon(
                            Icons.location_city,
                            color: Colors.black,
                          ),
                          title: Text(f.endereco),
                        ),
                        ListTile(
                          onTap: () async {
                            if (await canLaunch('tel:${f.telefone}')) {
                              await launch('tel:${f.telefone}');
                            } else {
                              Clipboard.setData(ClipboardData(text: f.telefone))
                                  .then((_) {
                                Get.snackbar('Copia', 'Telefone copiado');
                              });
                            }
                          },
                          leading: Icon(
                            Icons.local_phone,
                            color: Colors.black,
                          ),
                          title: Text(f.telefone),
                        ),
                        Divider(
                          thickness: 1,
                          color: ThemeUtils.primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Observer(builder: (_) {
                            return Text(
                                'Serviços (${controller.servicoSelecionados.length}) selecionado${controller.servicoSelecionados.length > 1 ? 's' : ''}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15));
                          }),
                        ),
                        buildServico()
                      ]),
                    ),
                  ],
                );
              }
              return Center(child: Text('Cilada Bino, taokei!!'));
              break;
            default:
              return Container();
          }
        });
  }

  Widget buildServico() {
    var formatReal = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return Observer(builder: (_) {
      return FutureBuilder(
          future: controller.fornecedorServicoFuture,
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
                  return Center(child: Text('Erro na parada aiiiee.'));
                }
                if (snapshot.hasData) {
                  var servicos = snapshot.data;
                  return Observer(builder: (_) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: servicos.length,
                        padding: EdgeInsets.only(
                            bottom: controller.servicoSelecionados.isNotEmpty
                                ? 60
                                : 0),
                        itemBuilder: (context, index) {
                          var serv = servicos[index];
                          return Observer(builder: (_) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.pets),
                              ),
                              title: Text(serv.nome),
                              subtitle: Text(formatReal.format(serv.valor)),
                              trailing: IconButton(
                                onPressed: () =>
                                    controller.adicionarOuRemoverServico(serv),
                                icon: controller.servicoSelecionados
                                        .contains(serv)
                                    ? Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                        size: 30,
                                      )
                                    : Icon(
                                        Icons.add_circle,
                                        color: ThemeUtils.primaryColor,
                                        size: 30,
                                      ),
                              ),
                            );
                          });
                        });
                  });
                }
                return Center(child: Text('Cilada Bino, taokei!!'));
                break;
              default:
                return Container();
            }
          });
    });
  }
}
