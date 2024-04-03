import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:task/app/modules/drawboard/controllers/drawboard_controller.dart';
import 'package:task/app/modules/form1/controllers/form1_controller.dart';
import 'package:task/app/modules/register_view/controllers/register_view_controller.dart';

class Form2Controller extends GetxController {
  final count = 1.obs;
  final form1 = Get.put<Form1Controller>(Form1Controller());
  final register = Get.put<RegisterViewController>(RegisterViewController());
  final drawboard = Get.put<DrawboardController>(DrawboardController());

  String uniquefile = DateTime.now().microsecondsSinceEpoch.toString();
  RxString fileurl = ''.obs;

  final Uint8List imageBytes =
      Uint8List.fromList(List.generate(256, (index) => index));
  var selectedImage = Rx<File?>(null);

  final List<TextEditingController> taskNameControllers = [];
  var filePath = '';

  final List<TextEditingController> taskDescriptionControllers = [];
  final RxList<List<File>> imagesList = <List<File>>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  addpdf(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'document': fileurl.value,
    });
  }

  @override
  void onClose() {
    taskNameControllers.forEach((controller) => controller.dispose());
    taskDescriptionControllers.forEach((controller) => controller.dispose());
    super.onClose();
  }

  Widget infofield(int index) {
    while (taskNameControllers.length <= index) {
      taskNameControllers.add(TextEditingController());
      taskDescriptionControllers.add(TextEditingController());
      imagesList.add([]); // Add a new list for images
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Text('Task ${index + 1}'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: taskNameControllers[index],
                decoration: InputDecoration(labelText: 'Task name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: taskDescriptionControllers[index],
                decoration: InputDecoration(labelText: 'Task Description'),
              ),
            ),
            Obx(
              () => Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: imagesList[index].map((imageFile) {
                  return Container(
                    height: 50,
                    width: 50,
                    child: Image.file(imageFile),
                  );
                }).toList(),
              ),
            ),
            TextButton(
              onPressed: () {
                pickImage(index);
                update();
              },
              child: Text('Add images'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(int index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageFile = File(image.path);
      selectedImage.value = imageFile;
      imagesList[index].add(imageFile); // Add the File object directly
      imagesList.refresh();
      print('image path is - ${imagesList[index].length}');
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void addSection() {
    count.value++;
  }

  Future<Uint8List> getImageBytes(File file) async {
    return await file.readAsBytes();
  }

  Future<void> generateAndDisplayPDF(Uint8List? capturedImage) async {
    final List<Future<Uint8List>> imageBytesFutures = [];

    // Collect image bytes from all lists
    for (var images in imagesList) {
      imageBytesFutures
          .addAll(images.map((imageFile) => getImageBytes(imageFile)));
    }

    final List<Uint8List> imageBytes = await Future.wait(imageBytesFutures);

    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            final List<pw.Widget> pdfContent = [];

            pdfContent.add(pw.Text(
                ' ----------------------------------User Information--------------------------------------'));
            pdfContent.add(pw.Text(
                '--this document contains confidential information should not be shared with anyone--'));
            pdfContent
                .add(pw.Text('User firstname - ${form1.firstname.text} '));
            pdfContent.add(pw.Text('User lastname - ${form1.lastname.text} '));
            pdfContent.add(pw.Text('User email - ${form1.email.text} '));
            pdfContent.add(pw.Text('User bio - ${form1.bio.text} '));
            pdfContent.add(pw.SizedBox(height: 10));

            for (int i = 0; i < count.value; i++) {
              pdfContent.add(
                pw.Text('Task ${i + 1}: ${taskNameControllers[i].text}'),
              );
              pdfContent.add(
                pw.Text(
                    'Task Description: ${taskDescriptionControllers[i].text}'),
              );

              // Center align the images
              pdfContent.add(
                pw.Center(
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: List.generate(
                      imagesList[i].length,
                      (index) {
                        return pw.Image(
                          pw.MemoryImage(imageBytes[index]),
                          width: 50,
                          height: 50,
                        );
                      },
                    ),
                  ),
                ),
              );
            }

            pdfContent.add(pw.SizedBox(height: 10));

            if (capturedImage != null) {
              pdfContent.add(
                pw.Image(
                  pw.MemoryImage(capturedImage),
                  width: 200,
                  height: 200,
                ),
              );
            }

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: pdfContent,
            );
          },
        ),
      );

      // Get the directory for saving the PDF file
      final directory = await getApplicationDocumentsDirectory();
      filePath = '${directory.path}/my_document.pdf';

      // Save the PDF document to a file
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      OpenFile.open(filePath);
    } catch (e) {
      print('Error generating PDF: $e');
      Get.snackbar('Error', 'Failed to generate PDF: $e');
    }

    //   try {

    //     Reference reference = FirebaseStorage.instance.ref();
    //     Reference refdir = reference.child('pdfs');
    //     Reference refimg = refdir.child(uniquefile);

    //     try {
    //       await refimg.putFile(File(filePath));

    //       print('pdf uploaded successfully.');
    //       filePath = await refimg.getDownloadURL();
    //       print('pdf url = ${filePath}');

    //       // Check if the user is authenticated
    //       if (FirebaseAuth.instance.currentUser != null) {
    //         print('user is authenticated');
    //         // User is authenticated, proceed with adding the PDF to Firestore
    //         addpdf(FirebaseAuth.instance.currentUser!);
    //       } else {
    //         // User is not authenticated, handle accordingly
    //         print('User is not authenticated.');
    //       }
    //     } catch (e) {
    //       print('Failed to upload pdf: $e');
    //     }
    //   } catch (e) {
    //     print('Error generating PDF: $e');
    //     Get.snackbar('Error', 'Failed to generate PDF: $e');
    //   }
  }
}
