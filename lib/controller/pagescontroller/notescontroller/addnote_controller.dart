import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddnoteController extends GetxController {

  late TextEditingController notetitle;
  late TextEditingController notecontent;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  CollectionReference firebaseFirestore = FirebaseFirestore.instance.collection('notes');
  String firebaseAuth = FirebaseAuth.instance.currentUser!.uid;

 addNote() async {
  if(formkey.currentState!.validate()){
    await firebaseFirestore.add({
      'title': notetitle.text,
      'content': notecontent.text,
      'timestamp': DateTime.now(),
      'userid': firebaseAuth
    });
    update();
    notetitle.clear();
    notecontent.clear();
    Get.back();
  }
 }

 @override
  void onInit() {
    notetitle = TextEditingController();
    notecontent = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    notetitle.dispose();
    notecontent.dispose();
    super.dispose();
  }

}