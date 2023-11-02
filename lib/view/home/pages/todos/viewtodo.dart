import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/controller/pagescontroller/todocontroller/viewtodo_controller.dart';
import 'package:notes/core/components/textforms/addnotefield.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/constant/sizes.dart';

class ViewTodo extends StatelessWidget {
  const ViewTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ViewtodoController());
    return Scaffold(
      body: GetBuilder<ViewtodoController>(builder: (controller){
        return Form(
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
                  child: IconButton(iconSize: 30, onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back),color: AppColors.primaryColor)
                )
                ]),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(onPressed: (){
                    controller.updatetodo();
                  }, icon: const Icon(Icons.check,size: 30)),
                )
              ]
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: AppSize.fifteen),
                child: Text(controller.timestamp.toString(),style: const TextStyle(color: AppColors.grey),),
              )
            ]
          ),
            SizedBox(height: AppSize.thirty),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 60,
                padding: const EdgeInsets.only(right: 10),
                child:  Center(
                  child: CustomAddNoteFormField(
                    mycontroller: controller.todotitle,
                    autofocus: false,
                    decoration: const InputDecoration(
                     border: InputBorder.none,
                     hintText: 'Task',      
                     hintStyle: TextStyle(fontSize: 25) 
                    ),
                    valid: (value){
                      if( value == null || value.isEmpty ) {
                       return "Task Can't Be Empty";
                      }return null ;
                    }, titleornote: true
                  )
                )
              )
            ),
            SizedBox(height: AppSize.twenty),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: AppSize.sixty,
                padding: const EdgeInsets.only(right: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(
                      children: [
                       const Padding(
                       padding: EdgeInsets.only(left: 10),
                       child: Icon(Icons.notifications_active_outlined,size: 30),
                       ), 
                       Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: (){
                            controller.picktime();
                          }, 
                          child: 
                          controller.selectedTime != null 
                          ? Text(DateFormat('d MMMM HH:mm').format(controller.selectedTime!),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.grey))
                          : controller.newselectedTime != null
                          ? Text(DateFormat('d MMMM HH:mm').format(controller.newselectedTime!),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.grey))
                          : const Text('Add Reminder',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.primaryColor)),
                        )
                       )
                      ]
                    ),
                    if (controller.selectedTime != null || controller.newselectedTime != null ) IconButton(onPressed: (){
                      controller.cleartext();
                    }, icon: const Icon(Icons.close)) 
                   ]
                  ) 
                ) 
              )
            ),
          ]
        )
      );
      })
    );
  }
}