import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes/core/functions/notificationservice.dart';
import 'package:notes/view/home/pages/todos/picktimetodo.dart';

class AddTodoController extends GetxController {

  late TextEditingController todotask;
  DateTime? selectedTime;
  bool ischecked = false;
  GlobalKey<FormState> forkey = GlobalKey<FormState>();
  CollectionReference firebaseFirestore = FirebaseFirestore.instance.collection('todos');
  String firebaseAuth = FirebaseAuth.instance.currentUser!.uid;

  picktime() async {
    selectedTime = await showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return PickTimeTodo(
          onDateTimeChanged: (DateTime newtime) {
            selectedTime = newtime;
          },
          result: selectedTime,
        );
      });
  }

  savetask() async {
    if (forkey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'title': todotask.text,
        'timestamp': DateTime.now(),
        'userid': firebaseAuth,
        'isdone': ischecked,
        'todotime': null
      };
      if (selectedTime != null) {
        data['todotime'] = selectedTime;
        String taskId = await firebaseFirestore.add(data).then((docRef) => docRef.id);
        NotificationService().scheduleNotification(
          id: taskId.hashCode,
          title: 'Reminder',
          body: todotask.text,
          scheduledNotificationDateTime: selectedTime!);
      }
      else {
      await firebaseFirestore.add(data);
    }
      todotask.clear();
      Get.back();
      selectedTime = null;
    }
    update();
  }

  @override
  void onInit() {
    todotask = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    todotask.dispose();
    super.onClose();
  }
}
