import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/core/functions/notificationservice.dart';
import 'package:notes/view/home/pages/todos/updatepicktime.dart';

class ViewtodoController extends GetxController {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  
  late TextEditingController todotitle;
  CollectionReference<Map<String, dynamic>> firebaseFirestore = FirebaseFirestore.instance.collection('todos');

  late final String title;
  late final String todoid;
  late final String timestamp;
  DateTime? selectedTime ;
  DateTime? newselectedTime ;
  bool forclear = false;

  cleartext() async {
    selectedTime = null;
    forclear = true;
    update();
  }

  picktime() async {
   newselectedTime = await showCupertinoModalPopup(
    context: Get.context!, 
    builder: (BuildContext context){
     return UpdatePickTimeTodo(
      onDateTimeChanged: (DateTime newtime){
        newselectedTime = newtime;
      },
      result: newselectedTime,
      );
    }
    );
    if(newselectedTime != null){
      selectedTime = null;
    }
    update();
  }

  updatetodo() async {
    if(formkey.currentState!.validate()){
      final String newtitle = todotitle.text.trim();
      Map<String , dynamic> data = {
        'title' : newtitle,
        'timestamp' : DateTime.now(),
      };
      if(forclear == true){
        NotificationService().cancelNotification(todoid.hashCode);
      }
      if(newselectedTime != null){
        data['todotime'] = newselectedTime;
        NotificationService().scheduleNotification(
          id: todoid.hashCode, 
          title: 'Reminder',
          body: todotitle.text,
          scheduledNotificationDateTime: newselectedTime!);
          NotificationService().cancelNotification(todoid.hashCode);
      }else{
        data['todotime'] = selectedTime;
      }
     await firebaseFirestore.doc(todoid).update(data);
     update();
     Get.back();
    }
  }

  @override
  void onInit() {
    title = Get.arguments['title'];
    todoid = Get.arguments['todoId'];
    if (Get.arguments['todotime'] != null) {
      selectedTime = Get.arguments['todotime']!.toDate();
    } else {
      selectedTime = null;
    }
    timestamp = DateFormat('d MMMM y').format(Get.arguments['timestamp'].toDate());
    todotitle = TextEditingController(text: title);
    super.onInit();
  }
  @override
  void onClose() {
    todotitle.dispose();
    super.onClose();
  }
}