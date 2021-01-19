import 'dart:convert';

import 'package:cuidape_curso/app/core/dio/custom_dio.dart';
import 'package:cuidape_curso/app/models/facebook_model.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookRepository {
  Future<FacebookModel> login() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['public_profile', 'emnail']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final resultFacebook = await CustomDio.instance.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        var model = FacebookModel.fromJson(json.decode(resultFacebook.data));
        model.token = token;
        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
        break;
      case FacebookLoginStatus.error:
        throw Exception(result.errorMessage);
        break;
      default:
        return null;
    }
  }
}
