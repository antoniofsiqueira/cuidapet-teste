import 'dart:io';

import 'package:cuidape_curso/app/repository/share_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushMessagingConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> configure() async {
    if (Platform.isIOS) {
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    String deviceId = await _fcm.getToken();
    final prefs = await SharedPrefsRepository.instance;
    prefs.registerDeviceId(deviceId);
  }
}
