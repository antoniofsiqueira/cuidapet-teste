import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  static void show() {
    Get.dialog(Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }

  static void hide() {
    Get.back();
  }
}
