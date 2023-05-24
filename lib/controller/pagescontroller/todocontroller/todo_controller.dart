import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes/core/functions/notificationservice.dart';

class TodoController extends GetxController {
  

  bool ischecked = false;
  CollectionReference firebaseFirestore = FirebaseFirestore.instance.collection('todos');
  String firebaseAuth = FirebaseAuth.instance.currentUser!.uid;

  chengechecked(int i, String? path) async {
    ischecked = !ischecked;
    await firebaseFirestore.doc(path).update({'isdone': ischecked});
    update([i]);
  }

  edittodo(Map data){
    Get.toNamed('viewtodo', arguments: data);
  }

  deletetask(String taskid) async {
    await firebaseFirestore.doc(taskid).delete();
    await NotificationService().cancelNotification(taskid.hashCode);
  }

}
