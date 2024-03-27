import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  ValueNotifier userCredential = ValueNotifier('');

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailValid = true;

  @override
  void onInit() {
    super.onInit();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        Get.snackbar('user not found', 'register the user',
            snackPosition: SnackPosition.TOP);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Wrong Password', 'Enter the correct password',
            snackPosition: SnackPosition.TOP);
      } else if (e.code == 'wrong-email') {
        Get.snackbar('Wrong Email!', 'Enter the registered email!',
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  void increment() => count.value++;
}
