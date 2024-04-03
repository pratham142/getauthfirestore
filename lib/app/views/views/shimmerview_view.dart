import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/app/modules/profile/controllers/profile_controller.dart';

class ShimmerviewView extends GetView {
  const ShimmerviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  _buildShimmerCircleAvatar(context),
                  SizedBox(height: 50),
                  _buildShimmerBox(context),
                  SizedBox(height: 10),
                  _buildShimmerBox(context),
                  SizedBox(height: 10),
                  _buildShimmerBox(context),
                  SizedBox(height: 25),
                  _buildShimmerBox(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerCircleAvatar(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.height * 0.15,
            backgroundColor: const Color.fromARGB(255, 230, 150, 150),
          ),
        ),
        Positioned(
          top: 170,
          right: 120,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Color.fromARGB(255, 255, 241, 241),
          ),
        )
      ],
    );
  }

  Widget _buildShimmerBox(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
              fillColor: Colors.amber,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        ));
  }
}
