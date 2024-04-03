import 'package:get/get.dart';

import '../controllers/drawboard_controller.dart';

class DrawboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawboardController>(
      () => DrawboardController(),
    );
  }
}
