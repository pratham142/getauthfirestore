import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/app/modules/form1/views/form1_view.dart';
import 'package:task/app/modules/profile/views/profile_view.dart';
import 'package:task/app/modules/register_view/views/register_view_view.dart';
import 'package:task/widgets.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Column(
          children: [
            Text('Dashboard'),
          ],
        )),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () {
                Get.to(() => ProfileView());
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                    'Welcome ! ${FirebaseAuth.instance.currentUser!.email}'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(Form1View());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add), Text('create form')],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
