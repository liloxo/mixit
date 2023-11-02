import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/auth/login_controller.dart';
import 'package:notes/core/components/auth/authinkwell.dart';
import 'package:notes/core/components/textforms/textformfield.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/functions/validinput.dart';

import '../../core/constant/sizes.dart';

class LogIn extends StatelessWidget {
   const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body : GetBuilder<LoginController>(
        builder: (controller){
        return controller.isloading 
          ?  const Center(
              child: CircularProgressIndicator(backgroundColor: AppColors.primaryColor,color: AppColors.primaryColor,))
          : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSize.twenty),
              child: Form(
                key: controller.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   SizedBox(height: AppSize.onefifty),
                   const Text('Login',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),
                   Container(
                    margin: EdgeInsets.symmetric(vertical: AppSize.twenty),
                    child: const Text('Please login to continue',style: TextStyle(color: AppColors.grey,fontSize: 20,fontWeight: FontWeight.w400))
                    ),
                   CustomTextFormField(
                    mycontroller: controller.email,
                    valid: (val) {
                        return validInput(val!, 6, 35, 'email');
                      },
                    labeltext: 'Email',isobscureText: false,keyboardType: TextInputType.emailAddress,hintText: 'Enter your email',prefixIcon: const Icon(Icons.email_outlined)),
                   CustomTextFormField(
                        mycontroller: controller.password,
                        valid: (val) {
                          return validInput(val!, 5, 50, 'password');
                        },
                      labeltext: 'Password',
                      isobscureText: controller.isobscureText,
                      hintText: 'Enter password',
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      suffixIcon: InkWell(
                        onTap: (){
                          controller.changeicon();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: AppSize.fifteen),
                          child: Text(
                            controller.isobscureText == true ? 'Show' : 'Hide',
                            ),
                        ),
                        ),
                      ),
                   Container(
                    margin: EdgeInsets.symmetric(vertical: AppSize.fifteen),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AuthInkWell(title: 'LOGIN',onTap: (){
                            controller.gotoHome();
                          },),
                        ],
                      )
                   ),
                   AuthChangePage(title: "Don't have an account? ",titletwo: 'Sign up', onTap: (){
                    Get.offNamed('signup');
                   },)
                ]
                ),
              )
            ),
          );
                })
      
      
    );
  }
}

