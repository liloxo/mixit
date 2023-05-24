import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes/core/services/myservices.dart';

class VerifyEmailController extends GetxController {

  String? email; 
  FirebaseAuth userCredential = FirebaseAuth.instance;
  MyServices myServices = Get.find();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isloading = false;

  Future<void> sendemail() async {
    await userCredential.currentUser!.sendEmailVerification();
  }

  gotologin()async{
    Get.offAllNamed('login');
  }

 @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}