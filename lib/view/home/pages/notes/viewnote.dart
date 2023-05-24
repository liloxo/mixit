import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/pagescontroller/notescontroller/viewnote_controller.dart';
import 'package:notes/core/components/textforms/addnotefield.dart';
import 'package:notes/core/constant/colors.dart';

class ViewNote extends StatelessWidget {
  
  const ViewNote({super.key});

  @override
  Widget build(BuildContext context) {
    ViewnoteController controller = Get.put(ViewnoteController());
    return  Scaffold(
      body: Form(
        key: controller.formkey,
        child: ListView(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Padding(
                padding: const EdgeInsets.only(left: 5),
                child: IconButton(iconSize: 30, onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back),color: AppColors.primaryColor),
              ),
              ]),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(onPressed: (){
                  controller.updateNote();
                }, icon: const Icon(Icons.check,size: 30,)),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(controller.timestamp,style: const TextStyle(color: AppColors.grey),),
              )
            ],
          ),
          const SizedBox(height: 15),
          CustomAddNoteFormField(
            mycontroller: controller.titleController,
            autofocus: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',      
              hintStyle: TextStyle(fontSize: 25) 
            ),
            valid: (value){
              if( value == null || value.isEmpty ) {
                return "Title Can't Be Empty";
              }return null ;
            }, titleornote: true,
            ),
          CustomAddNoteFormField(
              mycontroller: controller.noteController,
              autofocus: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note'
              ), titleornote: false,
          )
        ],
      ),
        )
    );
  }
}