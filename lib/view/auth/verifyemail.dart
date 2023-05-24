import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/auth/verifyemail_controller.dart';
import 'package:notes/core/constant/colors.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyEmailController());
    return  Scaffold(
      body: GetBuilder<VerifyEmailController>(builder: (controller){
        return controller.isloading
        ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
        : Column(
        children: [
          const SizedBox(height: 150),
          const Text("   We have sent a verification link to ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text(controller.email!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.grey)),
          const SizedBox(height: 30),
          MaterialButton(
            color: AppColors.primaryColor,
            onPressed: () async {
              await controller.gotologin();
            },
            child: const Text('Go to login',style: TextStyle(color: AppColors.white)),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            color: AppColors.grey,
            onPressed: () async {
              await controller.sendemail();
            },
            child: const Text('Send email again',style: TextStyle(color: AppColors.white)),
          ),
        ],
      );
      })
    );
  }
}