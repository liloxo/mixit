import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/pagescontroller/todocontroller/addtodo_controller.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/constant/sizes.dart';

class PickTimeTodo extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;
  final DateTime? result;
  const PickTimeTodo({Key? key, required this.onDateTimeChanged, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddTodoController controller = Get.put(AddTodoController());
    return SizedBox(
      height: AppSize.threeforty,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: AppSize.twentyfive),
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
           padding: EdgeInsets.only(bottom: AppSize.forty,top: AppSize.thirty),
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