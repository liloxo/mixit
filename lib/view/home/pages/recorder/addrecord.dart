import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/pagescontroller/recordercontroller/addrecordercontroller.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/constant/sizes.dart';

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
          SizedBox(height: AppSize.eighty),
          Padding(
            padding: EdgeInsets.only(left: 10,bottom: AppSize.forty),
            child: IconButton(onPressed: (){controller.cancelRecording();}, icon: const Icon(Icons.arrow_back,size: 30),color: AppColors.primaryColor)
          ),
          Center(
            child: Text('${(controller.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.elapsed.inSeconds % 60).toString().padLeft(2, '0')}',
             style: const TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: AppColors.grey)),
          ),
          SizedBox(height: AppSize.sixty),
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
          SizedBox(height: AppSize.eighty),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.saveorcancel ? const SizedBox() : 
                IconButton(
                  onPressed: () async {
                    await controller.startrecording();
                   }, 
                  icon: Icon(Icons.play_arrow_rounded,size: 50,color: controller.saveorcancel? null : AppColors.primaryColor)),
                  
                SizedBox(width: AppSize.thirtyfive),
                IconButton(onPressed: controller.saveorcancel ?
                () async {
                  if(controller.recorder.isRecording){
                          await controller.pauseRecording();
                        }else{
                          await controller.resumeRecording();
                        }
                }: null, icon: Icon(controller.recorder.isRecording ? Icons.pause_circle_filled : Icons.play_circle_fill,size: 50,color: controller.saveorcancel ? AppColors.primaryColor : AppColors.secondaryColor)),
                SizedBox(width: AppSize.thirtyfive),
                Container(
                  margin: controller.saveorcancel ? EdgeInsets.only(right: AppSize.thirtyfive) : null,
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