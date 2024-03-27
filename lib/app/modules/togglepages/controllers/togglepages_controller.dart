import 'package:get/get.dart';

class TogglepagesController extends GetxController {
  //TODO: Implement TogglepagesController

  final count = 0.obs;
  bool showloginpage = true;
  @override
  void onInit() {
    super.onInit();
  }

  void toggle() {
    showloginpage = !showloginpage;
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
