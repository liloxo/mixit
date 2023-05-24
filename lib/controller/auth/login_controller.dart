import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/services/myservices.dart';

class LoginController extends GetxController {
  MyServices myServices = Get.find();

  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool isobscureText = true;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth userCredential = FirebaseAuth.instance;
  bool isloading = false;

  changeicon(){
    isobscureText = isobscureText == true ? false : true ;
    update();
  }

  Future<FirebaseAuth> loginUser(String email, String password) async {
  try {
   await userCredential.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  } on FirebaseAuthException catch (e) {
     isloading = false;
     update();
    if (e.code == 'user-not-found') {
      Get.defaultDialog(title: 'Error',content: const Text('User not found'));
    } else if (e.code == 'wrong-password') {
      Get.defaultDialog(title: 'Error',content: const Text('Wrong password provided for that user.'));
    } else {
      //print('Error while logging in: ${e.code}');
    }
    rethrow;
  }
 }

  gotoHome() async {
   if(key.currentState!.validate()){
     isloading = true;
     update();
     await loginUser(email.text, password.text).then((value) async {

      if(userCredential.currentUser!.emailVerified){
        myServices.sharedPreferences.setString('email', email.text);
        myServices.sharedPreferences.setString('password', password.text);
        myServices.sharedPreferences.setString('step', '2').whenComplete(() => Get.offAllNamed('homepage'));
        isloading = false;
        update();
        
      }else{
        Get.offAllNamed('verifyemail',arguments: {
        'email': email.text,
      })!.then((value) => userCredential.currentUser!.sendEmailVerification());
      isloading = false;
      update();
      }
    });
    isloading = false;
    update();
   }
  }

  @override
  void onInit() {
    email    = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}