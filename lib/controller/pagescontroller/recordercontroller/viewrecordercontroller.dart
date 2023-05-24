import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:notes/core/constant/colors.dart';

class ViewRecorderController extends GetxController {

  CollectionReference firebaseFirestore = FirebaseFirestore.instance.collection('recorder');
  Reference firebaseStorage = FirebaseStorage.instance.ref('audios');
  final player = AudioPlayer();
  Duration position = Duration.zero;
  Duration? elapsed ;
  bool isPlaying = false;
  int? selectedAudioIndex;
  bool changes = false;
  bool ischecked = false;

  chengechecked(int i) async {
    ischecked = !ischecked;
    update([i]);
  }

  switchit(val) async {
    final newPosition = Duration(seconds: val.toInt());
    position = newPosition;
    await player.seek(newPosition);
    update();
  }

  Future<void> startplaying(String url,String? length,int index ) async {
    try {
      selectedAudioIndex = index;
      List<String> parts = length!.split(':');
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      int seconds = int.parse(parts[2]);
      elapsed = Duration(hours: hours, minutes: minutes, seconds: seconds);
      position = Duration.zero;
      await player.play(
        UrlSource(url)
      );
      changes = true;
      player.onPlayerComplete.listen((event) {
      changes = false;
      selectedAudioIndex = null;
      position = Duration.zero;
      update();
    });
      update();
    } catch (e) {
      // ignore: avoid_print
      print('Error playing recording: $e');
    }
  }

  Future pauseplaying() async {
      await player.pause();
      changes = false;
      update();
  }

  Future resumeplaying() async {
      await player.resume();
      changes = true;
      update();
  }

  
  editrecorder(String? path,String title) {
    TextEditingController textEditingController = TextEditingController(text: title);
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    Get.defaultDialog(
      title: 'Rename recorder',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: globalKey,
          child: TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                 color: AppColors.primaryColor
                )
              )
            ),
            controller: textEditingController,
            validator: (value){ 
              if( value == null || value.isEmpty ) {
                return "Title Can't Be Empty";
              }return null ;
              },
          )
        )
      ),
      cancel:  MaterialButton(onPressed: (){Get.back();},color: AppColors.white, child: const Text('Cancel',style: TextStyle(color: AppColors.primaryColor))),
      confirm: MaterialButton(onPressed: () async {
        if(globalKey.currentState!.validate()){
          await firebaseFirestore.doc(path).update({
          'title':textEditingController.text,
          });
          Get.back();
          update();
        }
      },color: AppColors.white, child: const Text('Confirm',style: TextStyle(color: AppColors.primaryColor)))
    );
  }
  
  deleterecorder(String? pathstore,String pathstorage) async {
   await firebaseFirestore.doc(pathstore).delete();
   await firebaseStorage.child(pathstorage).delete();
   update();
  }

  @override
  void onInit() {
    player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      update();
    });

    player.onDurationChanged.listen((newduration) {
      elapsed = newduration;
      update();
    });

    player.onPositionChanged.listen((newposition) {
      position = newposition;
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}