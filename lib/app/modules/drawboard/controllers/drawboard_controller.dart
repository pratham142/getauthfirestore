import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class DrawboardController extends GetxController {
  final count = 0.obs;
  final drawingBoardKey = GlobalKey();

  DrawingController drawingController = DrawingController();
  @override
  void onInit() {
    super.onInit();
  }

  Rx<Uint8List?> savedImage = Rx<Uint8List?>(null);

  // Method to update drawing data
  void updateDrawingData(Uint8List imageBytes) {
    savedImage.value = imageBytes;
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<Uint8List?> captureDrawing() async {
    final repaintBoundary = drawingBoardKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary?;

    if (repaintBoundary != null) {
      final image = await repaintBoundary.toImage(pixelRatio: 5.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        // Convert byte data to Uint8List
        Uint8List bytes = byteData.buffer.asUint8List();

        // Create ui.Image from bytes
        ui.Image capturedImage = await decodeImageFromList(bytes);

        // Calculate the size of the square (minimum dimension)
        int squareSize = capturedImage.width < capturedImage.height
            ? capturedImage.width
            : capturedImage.height;

        // Crop the image to a square
        ui.Rect squareRect = ui.Rect.fromLTWH(
          0, // Start from left
          0, // Start from top
          squareSize.toDouble(),
          squareSize.toDouble(),
        );

        // Create a new image to hold the cropped data
        ui.Image croppedImage = await instantiateImageCodec(bytes)
            .then((codec) => codec.getNextFrame())
            .then((frame) => frame.image)
            .then((image) {
          final recorder = ui.PictureRecorder();
          final canvas = Canvas(recorder);
          canvas.drawImageRect(
              image, squareRect, squareRect, Paint()); // Draw the cropped image
          return recorder.endRecording().toImage(squareSize, squareSize);
        });

        // Convert the cropped image to bytes
        ByteData? croppedByteData =
            await croppedImage.toByteData(format: ui.ImageByteFormat.png);

        if (croppedByteData != null) {
          return croppedByteData.buffer.asUint8List();
        }
      }
    }
    return null;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
