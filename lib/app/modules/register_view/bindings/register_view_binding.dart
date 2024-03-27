import 'package:get/get.dart';

import '../controllers/register_view_controller.dart';

class RegisterViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterViewController>(
      () => RegisterViewController(),
    );
  }
}
