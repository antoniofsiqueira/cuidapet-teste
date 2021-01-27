import 'dart:io';

import 'package:cuidape_curso/app/shared/componnent/cuidapet_textformfield.dart';
import 'package:cuidape_curso/app/shared/componnent/facebook_button.dart';
import 'package:cuidape_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: ScreenUtil.screenWidthDp,
              height: ScreenUtil.screenHeightDp,
              child: Stack(
                children: [
                  Container(
                    width: ScreenUtil.screenWidthDp,
                    height: ScreenUtil.screenHeightDp < 700
                        ? 800
                        : ScreenUtil.screenHeightDp * .95,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'lib/assets/images/login_background.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Platform.isIOS
                            ? ScreenUtil.statusBarHeight + 30
                            : ScreenUtil.statusBarHeight),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Image.asset(
                          'lib/assets/images/logo.png',
                          width: ScreenUtil().setWidth(400),
                          fit: BoxFit.fill,
                        ),
                        _buildForm(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            CuidapetTextFormField(
              controller: controller.loginController,
              label: 'Login',
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Login Obrigatório';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Observer(builder: (_) {
              return CuidapetTextFormField(
                controller: controller.senhaController,
                obscureText: controller.obscureText,
                suffixIcon: IconButton(
                  onPressed: () => controller.mostraSenhaUsuario(),
                  icon: Icon(Icons.lock),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Senha Obrigatória';
                  } else if (value.length < 6) {
                    return 'Senha precisa ser maior que 6 caracteres';
                  }
                  return null;
                },
              );
            }),
            Container(
              padding: EdgeInsets.all(10),
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () => controller.login(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: ThemeUtils.primaryColor,
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ou',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ThemeUtils.primaryColor),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    color: ThemeUtils.primaryColor,
                    thickness: 1,
                  ))
                ],
              ),
            ),
            FacebookButton(
              onTap: () => controller.facebookLogin(),
            ),
            FlatButton(
              onPressed: () => Modular.link.pushNamed('/cadastro'),
              child: Text('Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}
