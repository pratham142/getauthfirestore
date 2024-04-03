import 'package:get/get.dart';

import '../controllers/form2_controller.dart';

class Form2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Form2Controller>(
      () => Form2Controller(),
    );
  }
}
