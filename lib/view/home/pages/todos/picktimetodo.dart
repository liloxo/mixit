import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/pagescontroller/todocontroller/addtodo_controller.dart';
import 'package:notes/core/constant/colors.dart';

class PickTimeTodo extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;
  final DateTime? result;
  const PickTimeTodo({Key? key, required this.onDateTimeChanged, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddTodoController controller = Get.put(AddTodoController());
    return SizedBox(
           height: 320,
           child: Column(
             children: [
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.only(top: 25),
                   child: CupertinoDatePicker(
                     backgroundColor: AppColors.white,
                     minimumDate: DateTime.now(),
                     initialDateTime: DateTime.now(),
                     mode: CupertinoDatePickerMode.dateAndTime,
                     onDateTimeChanged: onDateTimeChanged)
                 )
               ),
               Container(
                color: AppColors.white,
                padding: const EdgeInsets.only(bottom: 40,top: 30),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  MaterialButton(onPressed: (){Get.back();},color: AppColors.white,child: const Text('Cancel',style: TextStyle(color: AppColors.primaryColor,fontSize: 17.5))),
                  MaterialButton(onPressed: (){
                    Get.back(result: controller.selectedTime);
                  },color: AppColors.white , child: const Text('Confirm',style: TextStyle(color: AppColors.primaryColor,fontSize: 17.5)))
                 ])
               )
             ]
           )
         );
  }
}