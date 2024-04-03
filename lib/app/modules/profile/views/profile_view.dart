import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/views/views/shimmerview_view.dart';
import 'package:task/widgets.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Obx(() {
        final isloading = controller.isLoading.value;
        return isloading
            ? ShimmerviewView()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        Stack(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.15,
                                backgroundColor:
                                    const Color.fromARGB(255, 230, 150, 150),
                                child: Obx(
                                  () => ClipOval(
                                    child: controller.imageurl.value.isNotEmpty
                                        ? Image.network(
                                            controller.imageurl.value,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          )
                                        : Icon(
                                            Icons.person,
                                            size: 200,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 170,
                              right: 120,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 241, 241),
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                  icon: Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => TextField(
                              controller: controller.updatename,
                              decoration: InputDecoration(
                                hintText: controller.username.value,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => TextField(
                              controller: controller.updateemail,
                              decoration: InputDecoration(
                                hintText: controller.email.value,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => TextField(
                              readOnly: true,
                              controller: controller.updatepassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: controller.password.value,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Defaultbutton(
                          onPressed: () {
                            controller.isLoading.value = true;
                            controller.updateProfile().then((_) {
                              controller.fetchUserDataFromFirestore().then((_) {
                                controller.isLoading.value = false;
                              });
                            });
                            controller.fetchUserDataFromFirestore();
                          },
                          title: 'Save',
                          size: 0.8,
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
