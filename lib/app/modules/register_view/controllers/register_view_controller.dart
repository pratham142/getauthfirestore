import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';

class RegisterViewController extends GetxController {
  //TODO: Implement RegisterViewController

  final count = 0.obs;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var username = 'name';
  var email = 'email';
  var password = 'passsword';

  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  String? uploadedImageUrl;
  // var selectedImage = Rx<File?>(null);
  UserCredential? userCredential;
  var imagepath = ''.obs;
  RxString imageUrl = ''.obs;

  String uniquefile = DateTime.now().microsecondsSinceEpoch.toString();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    selectedImage.value =
        await imagePicker.pickImage(source: ImageSource.gallery);
    update();
    print(selectedImage.value?.path);
    Reference reference = FirebaseStorage.instance.ref();
    Reference refdir = reference.child('images');
    Reference refimg = refdir.child(uniquefile);

    try {
      await refimg.putFile(File(selectedImage.value!.path));

      print('Image uploaded successfully.');
      imageUrl.value = await refimg.getDownloadURL();
      print('image url = ${imageUrl}');
      imagepath.value = imageUrl.value;
    } catch (e) {
      print('Failed to upload image: $e');
    }
  }

  Future<void> openCamera() async {
    ImagePicker imagePicker = ImagePicker();
    selectedImage.value =
        await imagePicker.pickImage(source: ImageSource.camera);
    print(selectedImage.value?.path);
    update();
    Reference reference = FirebaseStorage.instance.ref();
    Reference refdir = reference.child('images');
    Reference refimg = refdir.child(uniquefile);

    try {
      await refimg.putFile(File(selectedImage.value!.path));

      print('Image uploaded successfully.');
      imageUrl.value = await refimg.getDownloadURL();

      print('image url = ${imageUrl}');
    } catch (e) {
      print('Failed to upload image: $e');
    }
  }

  adduser(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'firstname': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'image': imageUrl.value,
    });
  }

  void Register() async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (userCredential != null && userCredential!.user != null) {
        await adduser(userCredential!.user!);
        print('User registered and data stored successfully');
      } else {
        print('Error: User object is null.');
      }
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
