import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forsignup extends GetxController {
  
  FirebaseAuth userCredential = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   
  Future signUpWithEmailAndPassword(String email, String password) async {
  try {
    await userCredential.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final currentUser = userCredential.currentUser;
      await currentUser!.sendEmailVerification();
      await firebaseFirestore.collection('users').doc(currentUser.uid).set({
        'email': email,
      });
      return true;
   
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Get.defaultDialog(title: 'Error',content: const Text('The password provided is too weak'));
    } else if (e.code == 'email-already-in-use') {
      Get.defaultDialog(title: 'Error',content: const Text('email-already-in-use'));
    }
    return false;
  } catch (e) {
    //print(e.toString());
  }
}
  
}
