import 'package:cuidape_curso/app/models/endereco_model.dart';
import 'package:cuidape_curso/app/modules/home/enderecos/detalhe/detalhe_controller.dart';
import 'package:cuidape_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetalhePage extends StatefulWidget {
  final EnderecoModel enderecoModel;

  const DetalhePage({Key key, @required this.enderecoModel}) : super(key: key);

  @override
  _DetalhePageState createState() => _DetalhePageState(enderecoModel);
}

class _DetalhePageState extends ModularState<DetalhePage, DetalheController> {
  final EnderecoModel model;
  final appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
  );

  _DetalhePageState(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          height: ScreenUtil.screenHeightDp -
              (ScreenUtil.statusBarHeight + appBar.preferredSize.height),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Confirme seu endereço',
                style: ThemeUtils.theme.textTheme.headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(model.latitude, model.longitude),
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                        markerId: MarkerId('end'),
                        position: LatLng(model.latitude, model.longitude),
                        infoWindow: InfoWindow(title: model.endereco))
                  },
                  myLocationButtonEnabled: false,
                ),
              ),
              TextFormField(
                initialValue: model.endereco,
                readOnly: true,
                decoration: InputDecoration(
                    labelText: 'Endereço',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    )),
              ),
              TextFormField(
                controller: controller.complementoTextController,
                decoration: InputDecoration(labelText: 'Complemento'),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: ScreenUtil.screenWidthDp * .9,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () => controller.salvarEndereco(model),
                    child: Text(
                      'Salvar',
                      style: TextStyle(fontSize: 20),
                    ),
                    color: ThemeUtils.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
