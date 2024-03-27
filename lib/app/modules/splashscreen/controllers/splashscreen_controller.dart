import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/authpage/views/authpage_view.dart';
import 'package:task/app/modules/login/views/login_view.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // Timer(Duration(seconds: 3), () => Get.off(AuthpageView()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
