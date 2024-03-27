import 'package:get/get.dart';

import '../controllers/togglepages_controller.dart';

class TogglepagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TogglepagesController>(
      () => TogglepagesController(),
    );
  }
}
