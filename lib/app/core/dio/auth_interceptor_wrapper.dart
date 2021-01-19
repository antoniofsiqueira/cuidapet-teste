import 'package:cuidape_curso/app/core/dio/custom_dio.dart';
import 'package:cuidape_curso/app/repository/security_storage_repository.dart';
import 'package:cuidape_curso/app/repository/share_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthInterceptorWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    final prefs = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = prefs.accessToken;

    if (DotEnv().env['profile'] == 'dev') {
      print('#####--Request Logs--#####');
      print('url = ${options.uri}');
      print('method = ${options.method}');
      print('data = ${options.data}');
      print('headers = ${options.headers}');
    }
  }

  @override
  Future onResponse(Response response) async {
    if (DotEnv().env['profile'] == 'dev') {
      print('#####--Response Logs--#####');
      print('data = ${response.data}');
    }
  }

  @override
  Future onError(DioError err) async {
    print('#####--Error Logs--#####');
    print('error: ${err.response}');
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      await _refreshToken();
      final req = err.request;
      return CustomDio.authInstance.request(req.path, options: req);
    }
    return err;
  }

  Future<void> _refreshToken() async {
    final prefs = await SharedPrefsRepository.instance;
    final security = SecurityStorageRepository();
    try {
      final refreshToken = await security.refreshToken;
      final accessToken = prefs.accessToken;
      var refreshResult = await CustomDio.instance.put('/login/refresh',
          data: {'token': accessToken, 'refresh_token': refreshToken});
      await prefs.registerAccessToken(refreshResult.data['access_token']);
      await security.registerRefreshToken(refreshResult.data['refresh_token']);
    } catch (e) {
      print(e);
      await prefs.logout();
    }
  }
}
