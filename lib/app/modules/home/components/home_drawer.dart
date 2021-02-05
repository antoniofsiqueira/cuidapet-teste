import 'dart:io';

import 'package:cuidape_curso/app/repository/share_prefs_repository.dart';
import 'package:cuidape_curso/app/services/usuario_services.dart';
import 'package:cuidape_curso/app/shared/componnent/loader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cuidape_curso/app/shared/auth_store.dart';
import 'package:image_picker/image_picker.dart';

class HomeDrawer extends Drawer {
  HomeDrawer()
      : super(
          child: Container(
              margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
              child: Observer(builder: (_) {
                var user = Modular.get<AuthStore>().usuarioLogado;
                return Column(
                  children: [
                    Container(
                      height: 200,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              backgroundImage: user.imagemAvatar != null
                                  ? NetworkImage(user.imagemAvatar)
                                  : NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs34FJvDFjm-F0V7yEbeEWx5-OfDVpbhy4Cw&usqp=CAU'),
                              radius: 100,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              child: InkWell(
                                onTap: () => _alterarImagemPerfil(),
                                child: Container(
                                    color: Colors.white54,
                                    child: Text(
                                      'Alterar imagem',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(user.email),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: Icon(Icons.receipt),
                          title: Text('Meus Agndamentos'),
                        ),
                        ListTile(
                          leading: Icon(Icons.chat),
                          title: Text('Chats'),
                        ),
                        ListTile(
                          onTap: () async {
                            final prefs = await SharedPrefsRepository.instance;
                            await prefs.logout();
                          },
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Sair'),
                        ),
                      ],
                    ),
                  ],
                );
              })),
        );

  static Future<void> _alterarImagemPerfil() async {
    Loader.show();
    var imageFile = await ImagePicker().getImage(source: ImageSource.camera);
    var reference = FirebaseStorage.instance
        .ref()
        .child('/perfil/${DateTime.now().millisecondsSinceEpoch.toString()}');

    var storageTask = await reference.putFile(File(imageFile.path)).onComplete;
    var url = await storageTask.ref.getDownloadURL();
    var novoUsuario =
        await Modular.get<UsuarioService>().atualizarImagemPerfil(url);
    final prefs = await SharedPrefsRepository.instance;
    await prefs.registerDadosUsuario(novoUsuario);
    await Modular.get<AuthStore>().loadUsuario();
    Loader.hide();
  }
}
