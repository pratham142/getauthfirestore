import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/widgets.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  final TextEditingController updatename = TextEditingController();
  final updatepassword = TextEditingController();
  final updateemail = TextEditingController();
  var username = 'name'.obs;
  var email = 'aaa@aa.com'.obs;
  var password = 'password'.obs;
  RxBool isLoading = false.obs;
  RxString imageurl = ''.obs;
  String uniquefile = DateTime.now().microsecondsSinceEpoch.toString();

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

  Future<void> updateProfile() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      if (updateemail.text.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'email': updateemail.text,
        });
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null && user.email != updateemail.text) {
          await user.updateEmail(updateemail.text);
        }
      }
      if (updatename.text.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'firstname': updatename.text,
        });
      }
      if (selectedImage.value!.path.isNotEmpty) {
        Reference reference = FirebaseStorage.instance.ref();
        Reference refdir = reference.child('updatedimages');
        Reference refimg = refdir.child(uniquefile);

        try {
          await refimg.putFile(File(selectedImage.value!.path));

          print('Image updated successfully.');
          print('previous image url = ${imageurl}');
          imageurl.value = await refimg.getDownloadURL();
          print('updated image url = ${imageurl}');
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'image': imageurl.value,
          });

          // imagepath.value = imageUrl.value;
        } catch (e) {
          print('Failed to upload image: $e');
        }
      }

      Get.snackbar('successfull', 'successfully updated information');
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar('Failed', 'failed to update');
    }
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageFile = File(image.path);
      selectedImage.value = imageFile;
      print('image path is - ${selectedImage.value!.path}');
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
