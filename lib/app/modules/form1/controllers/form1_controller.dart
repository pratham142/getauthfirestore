import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Form1Controller extends GetxController {
  //TODO: Implement Form1Controller

  final count = 0.obs;
  TextEditingController firstname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController lastname = TextEditingController();
  @override
  void onInit() {
    super.onInit();
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
