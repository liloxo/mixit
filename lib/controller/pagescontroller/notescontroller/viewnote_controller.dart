import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' ;

class ViewnoteController extends GetxController {

 late TextEditingController titleController;
 late TextEditingController noteController;

  late final String title;
  late final String note;
  late final String noteId;
  late final String timestamp;

 GlobalKey<FormState> formkey = GlobalKey<FormState>();
 FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

 updateNote()async{
  if(formkey.currentState!.validate()){
    final String newTitle = titleController.text.trim();
    final String newNote = noteController.text.trim();
    if (newTitle != title || newNote != note){
      await firebaseFirestore.collection('notes').doc(noteId).update({
      'title':titleController.text,
      'content': noteController.text,
      'timestamp': Timestamp.now()
    }).then((value) {
      Get.back();
    });
    }
  }
 }

  @override
  void onInit() {
    title = Get.arguments['title'];
    note = Get.arguments['content'];
    noteId = Get.arguments['noteId'];
    timestamp = DateFormat('d MMMM y').format(Get.arguments['timestamp'].toDate());
    titleController = TextEditingController(text: title);
    noteController = TextEditingController(text: note);
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    noteController.dispose();
    super.onClose();
  }
}