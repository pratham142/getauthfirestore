import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/drawboard/controllers/drawboard_controller.dart';
import 'package:task/app/modules/form2/controllers/form2_controller.dart';

class DrawboardView extends GetView<DrawboardController> {
  const DrawboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DrawboardController());
    Form2Controller form2controller = Get.put(Form2Controller());

    return Scaffold(
      appBar: AppBar(
        title: const Text('DrawboardView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              'Please provide your signature',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: RepaintBoundary(
              key: controller.drawingBoardKey,
              child: DrawingBoard(
                controller: controller.drawingController,
                background:
                    Container(width: 400, height: 400, color: Colors.white),
                showDefaultActions: true,
                showDefaultTools: true,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Capture and save the drawing
              Uint8List? imageBytes = await controller.captureDrawing();
              if (imageBytes != null) {
                controller.updateDrawingData(imageBytes);
              }
              form2controller.generateAndDisplayPDF(imageBytes);
            },
            child: Text('Save Drawing'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
