import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/core/services/myservices.dart';
import 'package:notes/routes.dart';
import 'package:get/get.dart';
import 'package:notes/view/auth/signup.dart';
import 'package:notes/view/home/homepage.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: myServices.sharedPreferences.getString("step") == "2" ? const HomePage() : const SignUp(),
      getPages: routes,
    );
  }
}
