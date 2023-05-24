import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/pagescontroller/recordercontroller/addrecordercontroller.dart';
import 'package:notes/core/constant/colors.dart';

class AddRecord extends StatelessWidget {
  const AddRecord({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddRecorderController());
    return Scaffold(
      body: GetBuilder<AddRecorderController>(builder: (controller){
       return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(left: 10,bottom: 40),
            child: IconButton(onPressed: (){controller.cancelRecording();}, icon: const Icon(Icons.arrow_back,size: 30),color: AppColors.primaryColor)
          ),
          Center(
            child: Text('${(controller.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.elapsed.inSeconds % 60).toString().padLeft(2, '0')}',
             style: const TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: AppColors.grey)),
          ),
          const SizedBox(height: 60),
          Center(
              child: 
                AvatarGlow(
                endRadius: 80,
                glowColor: AppColors.primaryColor,
                animate: controller.recorder.isRecording,
                repeat: true,
                child: Icon(Icons.keyboard_voice,size: 60,color: controller.recorder.isRecording ? AppColors.primaryColor : AppColors.secondaryColor),
              ) 
            ),
          const SizedBox(height: 80),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.saveorcancel ? const SizedBox() : 
                IconButton(
                  onPressed: () async {
                    await controller.startrecording();
                   }, 
                  icon: Icon(Icons.play_arrow_rounded,size: 50,color: controller.saveorcancel? null : AppColors.primaryColor)),
                  
                const SizedBox(width: 35),
                IconButton(onPressed: controller.saveorcancel ?
                () async {
                  if(controller.recorder.isRecording){
                          await controller.pauseRecording();
                        }else{
                          await controller.resumeRecording();
                        }
                }: null, icon: Icon(controller.recorder.isRecording ? Icons.pause_circle_filled : Icons.play_circle_fill,size: 50,color: controller.saveorcancel ? AppColors.primaryColor : AppColors.secondaryColor)),
                const SizedBox(width: 35),
                Container(
                  margin: controller.saveorcancel ? const EdgeInsets.only(right: 35) : null,
                  child: IconButton(
                    onPressed: controller.saveorcancel ?
                    () async {
                    await controller.stopRecording();
                    } 
                    : null,
                    icon: Icon(Icons.stop_circle_outlined,size: 50, color: controller.saveorcancel ? AppColors.primaryColor : AppColors.secondaryColor)),
                )
              ]
            )
        ]
      );
      })
    );
  }
}