import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/pagescontroller/notescontroller/addnote_controller.dart';
import 'package:notes/core/components/textforms/addnotefield.dart';
import 'package:notes/core/constant/colors.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    AddnoteController controller = Get.put(AddnoteController());
    return  Scaffold(
      body: Form(
        key: controller.formkey,
        child: ListView(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Padding(
                padding: const EdgeInsets.only(left: 5),
                child: IconButton(iconSize: 30, onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back),color: AppColors.primaryColor),
              ),
              const Padding(
                padding:  EdgeInsets.only(left: 10),
                child: Text(" Add Note ", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.primaryColor)),
              ),
              ]),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(onPressed: (){controller.addNote();}, icon: const Icon(Icons.check,size: 30,)),
              )
            ],
          ),
          const SizedBox(height: 15),
          CustomAddNoteFormField(
            mycontroller: controller.notetitle,
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
            maxLines: null,
              mycontroller: controller.notecontent,
              autofocus: true,
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