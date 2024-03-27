import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/app/modules/home/views/home_view.dart';
import 'package:task/app/modules/login/views/login_view.dart';

import '../controllers/authpage_controller.dart';

class AuthpageView extends GetView<AuthpageController> {
  const AuthpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeView();
          } else {
            return LoginView();
          }
        },
      ),
    );
  }
}
