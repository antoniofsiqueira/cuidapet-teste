import 'package:cuidape_curso/app/models/fornecedor_busca_model.dart';
import 'package:cuidape_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';

class EstabelecimentoCard extends StatelessWidget {
  final FornecedorBuscaModel _fornecedor;
  const EstabelecimentoCard(this._fornecedor, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.only(top: 40, left: 10, right: 10),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: double.infinity,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(_fornecedor.nome,
                      style: ThemeUtils.theme.textTheme.subtitle2),
                  Text('${_fornecedor.distancia.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(_fornecedor.logo),
            ),
          ),
        ),
      ],
    );
  }
}
