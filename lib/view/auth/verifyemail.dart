import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/auth/verifyemail_controller.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/constant/sizes.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyEmailController());
    return  Scaffold(
      body: GetBuilder<VerifyEmailController>(builder: (controller){
        return controller.isloading
        ? const Center(child: CircularProgressIndicator(backgroundColor: AppColors.primaryColor,color: AppColors.primaryColor,))
        : Column(
        children: [
          SizedBox(height: AppSize.onefifty),
          const Text("   We have sent a verification link to ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
          SizedBox(height: AppSize.fifteen),
          Text(controller.email!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.grey)),
          SizedBox(height: AppSize.thirty),
          MaterialButton(
            color: AppColors.primaryColor,
            onPressed: () async {
              await controller.gotologin();
            },
            child: const Text('Go to login',style: TextStyle(color: AppColors.white)),
          ),
          SizedBox(height: AppSize.thirty),
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