import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/app/modules/drawboard/controllers/drawboard_controller.dart';
import 'package:task/app/modules/form2/controllers/form2_controller.dart';
import 'package:task/app/modules/form2/views/form2_view.dart';
import 'package:task/widgets.dart';

import '../controllers/form1_controller.dart';

class Form1View extends GetView<Form1Controller> {
  const Form1View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(Form1Controller());

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Form2View());
          },
          child: Icon(Icons.arrow_forward_ios_rounded),
        ),
        appBar: AppBar(
          title: const Text('Form1View'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaulttextfield(
                    controller: controller.firstname, text: 'firstname'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaulttextfield(
                    controller: controller.lastname, text: 'lastname'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaulttextfield(
                    controller: controller.address, text: 'adddress'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    defaulttextfield(controller: controller.bio, text: 'bio'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaulttextfield(
                    controller: controller.email, text: 'email'),
              ),
            ],
          ),
        ));
  }
}
