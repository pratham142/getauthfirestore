import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  final TextEditingController updatename = TextEditingController();
  final updatepassword = TextEditingController();
  final updateemail = TextEditingController();
  var username = 'name'.obs;
  var email = 'aaa@aa.com'.obs;
  var password = 'password'.obs;
  RxString imageurl = ''.obs;
  var selectedImage = Rx<File?>(null);
  @override
  void onInit() {
    super.onInit();
    fetchUserDataFromFirestore();
  }

  Future<void> fetchUserDataFromFirestore() async {
    print('object');
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      print(uid);
      if (uid != null) {
        DocumentSnapshot doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        print(doc);

        if (doc.exists) {
          username.value = doc['firstname'];
          email.value = doc['email'];
          password.value = doc['password'];
          imageurl.value = doc['image'];
          print(username);
          print(imageurl.value);
        }
      }
    } catch (e) {
      print('Failed to fetch user data: $e');
    }
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageFile = File(image.path);
      selectedImage.value = imageFile;
      print('image path is - ${image.path}');
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> openCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageFile = File(image.path);
      selectedImage.value = imageFile;
      print('image path is - ${image.path}');
    } catch (e) {
      print('Failed to pick image: $e');
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
