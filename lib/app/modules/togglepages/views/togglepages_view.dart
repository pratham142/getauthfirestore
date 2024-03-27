import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/app/modules/login/views/login_view.dart';
import 'package:task/app/modules/register_view/views/register_view_view.dart';

import '../controllers/togglepages_controller.dart';

class TogglepagesView extends GetView<TogglepagesController> {
  const TogglepagesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (controller.showloginpage) {
      return LoginView(onPressed: () {
        controller.showloginpage = !controller.showloginpage;
      });
    } else {
      return RegisterViewView();
    }
  }
}
