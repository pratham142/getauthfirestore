import 'package:get/get.dart';

import '../controllers/form1_controller.dart';

class Form1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Form1Controller>(
      () => Form1Controller(),
    );
  }
}
