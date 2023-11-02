import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/controller/home/homepage_controller.dart';
import 'package:notes/controller/pagescontroller/recordercontroller/viewrecordercontroller.dart';
import 'package:notes/core/components/slidable/slidable.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/view/widget/emptycolumn/customemptycolumn.dart';

import '../../../../core/constant/sizes.dart';

class Recorder extends StatelessWidget {
  const Recorder({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ViewRecorderController());
    return Scaffold(
        floatingActionButton: 
        FloatingActionButton(
          backgroundColor:AppColors.primaryColor,
          child: const Icon(Icons.keyboard_voice_rounded,color :AppColors.white,size: 30,),
          onPressed: (){ 
             Get.toNamed('addrecord');
            }),
        body: GetBuilder<HomePageController>(builder: (controllerobx){
          return StreamBuilder(
         stream: controllerobx.streamquerysnapshot('recorder'),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something Went Wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(backgroundColor: AppColors.primaryColor,color: AppColors.primaryColor,));
          } else if (snapshot.data?.docs.isEmpty ?? true) {
            return const Center(
              child:  CustomEmptyColumn(
              data: 'No Recordings',
              icon: Icons.mic_none));
          }
          return GetBuilder<ViewRecorderController>(
            builder: (controller){
            return Column(children: [
                Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data.docs.length,
                      separatorBuilder: (BuildContext context, int i) {
                        return const SizedBox(height: 7);
                      },
                      itemBuilder: (BuildContext context, int i) {
                        String formattedDuration = '${controller.position.inHours}:${controller.position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(controller.position.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
                        bool isSelected = i == controller.selectedAudioIndex;
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                                child: MySlidable(
                                  onPressedDelete: (p0) {
                                   controller.deleterecorder(snapshot.data.docs[i].id, snapshot.data.docs[i]['pathstorage']);
                                  },
                                  onPressedEdit: (p0) {
                                   controller.editrecorder(snapshot.data.docs[i].id, snapshot.data.docs[i]['title']);
                                  },
                                  child: Container(
                                    height: isSelected ? AppSize.onefifty : AppSize.hundred,
                                    padding: EdgeInsets.only(right: 10,top: AppSize.twenty,left: AppSize.fifteen),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(snapshot.data.docs[i]['title'].toString(),style: const TextStyle(fontSize: 19,color:AppColors.black,fontWeight: FontWeight.w500)),
                                                const SizedBox(height: 8),
                                                Text(DateFormat('yMd').format(snapshot.data.docs[i]['timestamp'].toDate()),style: const TextStyle(fontSize: 15,color:AppColors.grey,fontWeight: FontWeight.w500))
                                              ]
                                            ),
                                            Row(children: [
                                              Text(snapshot.data.docs[i]['duration']),
                                              IconButton(onPressed: () async {
                                               if(controller.isPlaying){
                                                if(isSelected){
                                                  if(controller.changes){
                                                   controller.pauseplaying();
                                                  }else{
                                                   controller.resumeplaying();
                                                  }
                                                }else{
                                                  controller.startplaying(snapshot.data.docs[i]['url'],snapshot.data.docs[i]['duration'],i);
                                                }
                                              }else{
                                                controller.startplaying(snapshot.data.docs[i]['url'],snapshot.data.docs[i]['duration'],i);
                                              }
                                             }, icon: Icon(
                                              isSelected 
                                              ? controller.changes ? Icons.pause_circle_outline : Icons.play_circle_outline 
                                              : Icons.play_circle_outline,
                                              color: AppColors.primaryColor,size: 30))
                                            ])
                                          ]
                                        ),
                                        if (isSelected) Expanded(
                                            child: Column(
                                              children: [
                                                Slider(
                                                   min: 0,
                                                   max: controller.elapsed!.inSeconds.toDouble(),
                                                   value: controller.position.inSeconds.toDouble(),
                                                   activeColor: AppColors.primaryColor,
                                                   secondaryActiveColor: AppColors.primaryColor,
                                                   inactiveColor: AppColors.white,
                                                   onChanged: (val) {
                                                    controller.switchit(val);
                                                   }
                                                ),
                                                Container(
                                                 padding: const EdgeInsets.all(5),
                                                 child:
                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                   Text(formattedDuration),
                                                   Text(snapshot.data.docs[i]['duration'])
                                                 ]))
                                              ]
                                            )
                                          ) else const SizedBox.shrink()
                                      ]
                                    )
                                )
                                  ))
                              )
                        );
                      })
                )
              ]);
          });
        }
    );
        }));
  }
}