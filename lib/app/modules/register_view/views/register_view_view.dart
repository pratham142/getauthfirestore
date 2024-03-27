import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:task/app/modules/register_view/controllers/register_view_controller.dart';
import 'package:task/widgets.dart';

class RegisterViewView extends GetView<RegisterViewController> {
  const RegisterViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterViewController());
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              controller.openCamera();
                            },
                            child: Text('Open Camera'),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.pickImage();
                            },
                            child: Text('Open gallery'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.height * 0.15,
                backgroundColor: const Color.fromARGB(255, 230, 150, 150),
                child: Obx(
                  () => Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.15,
                          backgroundColor:
                              const Color.fromARGB(255, 230, 150, 150),
                          child: ClipOval(
                            child: controller.selectedImage.value != null
                                ? Image.file(
                                    File(controller.selectedImage.value!.path),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 100,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        right: 20,
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 206, 126, 126),
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            defaulttextfield(
              controller: controller.nameController,
              text: 'Name',
              hintText: controller.username,
            ),
            SizedBox(height: 10),
            Emailvalidationtextfield(
                emailController: controller.emailController),
            SizedBox(height: 10),
            Passwordvalidationtextfield(
              passwordController: controller.passwordController,
              obscure: false,
            ),
            SizedBox(height: 25),
            Defaultbutton(
              onPressed: () async {
                controller.Register();
                print('registered');

                Navigator.pop(context);
              },
              title: 'Register',
              size: 0.8,
            ),
            DefaultTextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Or Login',
              color: Colors.black,
            ),
          ]),
        ),
      ),
    ));
  }
}
