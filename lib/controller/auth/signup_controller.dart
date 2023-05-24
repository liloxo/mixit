import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/services/myservices.dart';
import 'package:notes/data/authforfirebase/authforsignup.dart';

class SignUpController extends GetxController {

  Forsignup forsignup   = Get.put(Forsignup());
  MyServices myServices = Get.find();
  CollectionReference<Map<String, dynamic>> firebaseFirestore = FirebaseFirestore.instance.collection('users');
  FirebaseAuth userCredential = FirebaseAuth.instance;
  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool isobscureText = true;
  bool isloading = false;

  changeicon(){
    isobscureText = isobscureText == true ? false : true ;
    update();
  }

  signupAnnonymous() async {
    isloading = true;
    update();
    await userCredential.signInAnonymously();
    await firebaseFirestore.doc(userCredential.currentUser!.uid).set({
      'useruid': userCredential.currentUser!.uid,
    });
    await myServices.sharedPreferences.setString('step', '2').
     whenComplete(() => Get.offAllNamed('homepage'));
    isloading = false;
    update();
  }

  gotoHome() async {
  if (key.currentState!.validate()) {
    isloading = true;
    update();
    final isSignedUp = await forsignup.signUpWithEmailAndPassword(
        email.text, password.text );
    if (isSignedUp) {
      forsignup.userCredential.currentUser!.sendEmailVerification();
        await myServices.sharedPreferences.setString('email', email.text);
        await myServices.sharedPreferences.setString('password', password.text);
        Get.offAllNamed('verifyemail', arguments: {'email': email.text});
    }
    isloading = false;
    update();
    email.clear();
    password.clear();
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