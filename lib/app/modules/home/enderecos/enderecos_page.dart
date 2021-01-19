import 'package:cuidape_curso/app/models/endereco_model.dart';
import 'package:cuidape_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';

import 'enderecos_controller.dart';

class EnderecosPage extends StatefulWidget {
  const EnderecosPage({Key key}) : super(key: key);

  @override
  _EnderecosPageState createState() => _EnderecosPageState();
}

class _EnderecosPageState
    extends ModularState<EnderecosPage, EnderecosController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.buscarEnderecosCadastrados();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                'Adcione um endereço',
                style: ThemeUtils.theme.textTheme.headline5
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: controller.enderecoTextController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        hintText: 'Insira um endereço',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                      ),
                    ),
                    suggestionsCallback: (String pattern) async {
                      return await controller.buscaEnderecos(pattern);
                    },
                    itemBuilder: (BuildContext context, Prediction itemData) {
                      return ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(itemData.description),
                      );
                    },
                    onSuggestionSelected: (Prediction suggestion) {
                      controller.enderecoTextController.text =
                          suggestion.description;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  onTap: () => controller.minhaLocalizacao(),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                    ),
                    radius: 30,
                    backgroundColor: Colors.red,
                  ),
                  title: Text('localização Atual'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              SizedBox(height: 10),
              FutureBuilder<List<EnderecoModel>>(
                  future: controller.enderecosFuture,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Container();
                        break;
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                        break;

                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          var data = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) =>
                                _buildItemEndereco(data[index]),
                          );
                        } else {
                          return Center(
                            child: Text('Nada de endereços'),
                          );
                        }

                        break;
                      default:
                        return Container();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemEndereco(EnderecoModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
        title: Text(model.endereco),
        subtitle: Text(model.complemento),
      ),
    );
  }
}
