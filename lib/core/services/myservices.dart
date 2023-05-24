import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:notes/core/functions/notificationservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;


class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

 Future<MyServices> init() async {

  sharedPreferences = await SharedPreferences.getInstance() ;
  await Firebase.initializeApp();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  return this;
  
 }
}
initialServices() async {
  await Get.putAsync(() => MyServices().init());
}