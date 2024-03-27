import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/authpage/views/authpage_view.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        Icon(Icons.info_rounded);
      },
      onEnd: () {
        Icon(Icons.swipe_right);
      },
      childWidget: SizedBox(
          height: 200,
          width: 200,
          child: Icon(
            Icons.ac_unit_outlined,
            size: 200,
          )),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const AuthpageView(),
    );
  }
}
