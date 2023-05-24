import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  var text = 'Hold the button and start speaking';
  bool isListening = false;
  SpeechToText speechToText = SpeechToText();
  Timer? resetTimer;

  @override
  void dispose() {
    resetTimer?.cancel();
    super.dispose();
  }

  void startListening() async {
    if (!isListening) {
      var available = await speechToText.initialize();
      if (available) {
        setState(() {
          isListening = true;
          speechToText.listen(
            pauseFor: const Duration(seconds: 10),
            onResult: (result) {
              setState(() {
                text = result.recognizedWords;
              });
            }
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.blueGrey,
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true, 
        endRadius: 75,
        child: GestureDetector(
          onTapDown: (details) async {
            startListening();
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            radius: 35,
            child: Icon(isListening ? Icons.mic : Icons.mic_none,color: Colors.white,),
          ),
        )
        ),
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.blueGrey,
        title: const Text('SpeechText'),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
            margin: const EdgeInsets.only(bottom: 120),
            child: Text(text,style: const TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w600)),
          ),
        )
    );
  }
}
