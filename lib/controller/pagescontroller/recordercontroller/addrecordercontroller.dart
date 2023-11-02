import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddRecorderController extends GetxController {
  final recorder = FlutterSoundRecorder();
  late Timer timer;
  Duration elapsed = Duration.zero;
  String? filePath;
  bool isready = false;
  bool saveorcancel = false;
  String? title;
  String firebaseAuth = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference<Map<String, dynamic>> firebaseFirestore = FirebaseFirestore.instance.collection('recorder');

  Future checkPermissions() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    isready = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
    update();
  }

  Future startrecording() async {
    if (!isready) return checkPermissions();
    await recorder.startRecorder(toFile: 'audio');
    timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      saveorcancel = true;
      elapsed += const Duration(milliseconds: 500);
      update();
    });
  }

  Future pauseRecording() async {
    await recorder.pauseRecorder();
    timer.cancel();
    update();
  }

  Future resumeRecording() async {
    if (!isready) return checkPermissions();
    await recorder.resumeRecorder();
    timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      elapsed += const Duration(milliseconds: 500);
      update();
    });
  }

  Future stopRecording() async {
   Duration duration = Duration(milliseconds: elapsed.inMilliseconds);
   String formattedDuration = '${duration.inHours}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
   String pathstorage = '${DateTime.now().toString()}.aac';
    if (!isready) return checkPermissions();
    timer.cancel();
    Get.back();
    // Stop the recorder and get the file path of the recorded audio
    String? path = await recorder.stopRecorder();
    File audiofile = File(path!);
    // Save the recorded audio file and its duration
    Reference firestorage = FirebaseStorage.instance.ref('audios').child(pathstorage);
    await firestorage.putFile(audiofile);
    // Get the Url
    String url = await firestorage.getDownloadURL();
    // save audio duration
    await firebaseFirestore.doc().set({
      'title': title ?? DateFormat('yyyyMMdd_HHmm').format(DateTime.now()),
      'userid': firebaseAuth,
      'url': url,
      'duration': formattedDuration,
      'timestamp': DateTime.now(),
      'pathstorage': pathstorage
    });
    // Reset the elapsed duration
    elapsed = Duration.zero;
    update();
  }

  Future cancelRecording() async {
    if (!isready) {Get.back();}
    if(saveorcancel ==true){
      timer.cancel();
    await recorder.stopRecorder();
    if (filePath != null) {
      final audioFile = File(filePath!);
      if (await audioFile.exists()) {
        await audioFile.delete();
      }
    }
    elapsed = Duration.zero;
    Get.back();
    update();
    }else{
      Get.back();
    }
  }

  @override
  void onInit() {
    checkPermissions();
    super.onInit();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }
}
