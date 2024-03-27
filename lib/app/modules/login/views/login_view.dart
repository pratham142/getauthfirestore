import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/app/modules/register_view/views/register_view_view.dart';
import 'package:task/widgets.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final VoidCallback? onPressed;

  LoginView({Key? key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 200,
                ),
                SizedBox(height: 70),
                SizedBox(
                  height: 100,
                  child: Emailvalidationtextfield(
                      emailController: controller.emailController),
                ),
                SizedBox(height: 15),
                Passwordvalidationtextfield(
                    passwordController: controller.passwordController),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Get.to(() => RegisterViewView());
                  },
                  child: Text('Register Now'),
                ),
                SizedBox(height: 25),
                Defaultbutton(
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: controller.emailController.text,
                          password: controller.passwordController.text);
                    },
                    title: 'Login'),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        thickness: 1,
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or Sign Up With',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 11, 11, 11),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: const Color.fromARGB(255, 28, 28, 28),
                        thickness: 1,
                        height: 20,
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      controller.signInWithGoogle();
                    },
                    icon: Image.network(
                      'https://1000logos.net/wp-content/uploads/2021/05/Google-logo-500x281.png',
                      height: 100,
                      width: 100,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
