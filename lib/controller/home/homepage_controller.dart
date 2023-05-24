import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/services/myservices.dart';
import 'package:notes/view/home/pages/notes/notes.dart';
import 'package:notes/view/home/pages/recorder/forrecorderstream.dart';
import 'package:notes/view/home/pages/todos/todo.dart';
import 'dart:async';

class HomePageController extends GetxController {

 int currentpage = 0;
 FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
 FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 MyServices myServices = Get.find();
 bool searchbool = false;
 String value = '';
 Timer? debouncee;

 onSearchChanged(String val) {
    if (debouncee?.isActive ?? false) debouncee!.cancel();
    debouncee = Timer(const Duration(milliseconds: 500), () {
      if(val == ''){
       searchbool = false;
      }else{
       searchbool = true;
       value = val;
      }
      update();
    });
  }

 streamquerysnapshot(String? collectionPath){
    Stream<QuerySnapshot<Object?>>? querySnapshot = searchbool 
    ? firebaseFirestore.collection(collectionPath!)
    .where('userid', isEqualTo:firebaseAuth.currentUser!.uid)
    .where('title',isGreaterThanOrEqualTo: value)
    .where('title',isLessThanOrEqualTo: '$value\uf8ff').snapshots()
    : firebaseFirestore.collection(collectionPath!).where('userid', isEqualTo:firebaseAuth.currentUser!.uid).orderBy('timestamp', descending: true).snapshots();
    return querySnapshot;
  }

  signoutmeth() async { 
    myServices.sharedPreferences.clear();
    Get.offAllNamed('signup');
    await firebaseAuth.signOut();
  }

  List<Widget> pages = [
  const Notes(),
  const ToDo(),
  const Recorder(),
 // const Mix()
  ];

  List<IconData> icons = [
    Icons.note,
    Icons.today_outlined,
    Icons.record_voice_over,
  //  Icons.home_max,
  ];
  List title = [
    "Notes" , 
    "ToDos" , 
    "Recorders" , 
 //   "Mixes"
  ]; 
  List<String> lowercasetitle = [
    "notes" , 
    "todos" , 
    "recorder" , 
 //   "mixes"
  ];

 changepage(int i){
  currentpage = i;
  update();
 }

 @override
  void dispose() {
    debouncee?.cancel();
    super.dispose();
  }

}