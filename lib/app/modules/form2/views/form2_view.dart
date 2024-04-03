import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task/app/modules/drawboard/views/drawboard_view.dart';

import '../controllers/form2_controller.dart';

class Form2View extends GetView<Form2Controller> {
  const Form2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Form2Controller());

    print(controller.count);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                for (var i = 0;
                    i < controller.taskNameControllers.length;
                    i++) {
                  print(controller.taskNameControllers[i].text);
                }
                Get.to(DrawboardView());
              },
            ),
          )
        ],
        title: const Text('Form2View'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.count.value,
                  itemBuilder: (context, index) {
                    return controller.infofield(
                      index,
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.addSection();
                },
                child: Text('add section'))
          ],
        ),
      ),
    );
  }
}
