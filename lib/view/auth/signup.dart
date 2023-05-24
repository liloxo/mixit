import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/auth/signup_controller.dart';
import 'package:notes/core/components/auth/authinkwell.dart';
import 'package:notes/core/components/textforms/textformfield.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/functions/validinput.dart';

class SignUp extends StatelessWidget {
   const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Scaffold(
      body : GetBuilder<SignUpController>(builder: (controller){
                  return controller.isloading 
                  ?  const Center(
                      child: CircularProgressIndicator(color: AppColors.primaryColor))
                  : SingleChildScrollView(
                    child:
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                        key: controller.key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           const SizedBox(height: 150),
                           const Text('SignUp',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),
                           Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: const Text('Please SignUp to continue',style: TextStyle(color: AppColors.grey,fontSize: 20,fontWeight: FontWeight.w400))
                            ),
                           CustomTextFormField(
                            mycontroller: controller.email,
                            valid: (val){
                              return validInput(val!, 6, 35, 'email');
                            },
                            labeltext: 'Email',
                            isobscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Enter email',
                            prefixIcon: const Icon(Icons.email_outlined)
                            ),
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
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  controller.isobscureText == true ? 'Show' : 'Hide',
                                  )
                              )
                              )
                            ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                              AuthGuest(
                                onTap: () {
                                  controller.signupAnnonymous();
                                },
                              ),
                               Container(
                                margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AuthInkWell(title: '  SIGNUP',onTap: (){
                                        controller.gotoHome();
                                      })
                                    ]
                                  )
                               )
                             ]
                           ),
                           AuthChangePage(title: "Already have an account? ",titletwo: 'Log in', onTap: (){
                            Get.offNamed('login');
                           })
                        ]
                        )
                        )
                      )
                  );
                })
      
    );
  }
}