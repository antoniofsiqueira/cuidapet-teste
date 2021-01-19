import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityStorageRepository {
  static const REFRESH_TOKEN = '/REFRESH_TOKEN/';

  Future<void> registerRefreshToken(String token) async {
    final store = FlutterSecureStorage();
    return await store.read(key: REFRESH_TOKEN);
  }

  Future<String> get refreshToken async {
    final store = FlutterSecureStorage();
    return await store.read(key: REFRESH_TOKEN);
  }
}
