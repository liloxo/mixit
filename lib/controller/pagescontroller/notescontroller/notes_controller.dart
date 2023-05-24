import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesController extends GetxController {

  CollectionReference firebaseFirestore = FirebaseFirestore.instance.collection('notes');

 deleteNote(String noteid)async{
  firebaseFirestore.doc(noteid).delete();
 }

 editNote(Map data){
  Get.toNamed('viewnote', arguments: data);
 }
 
}