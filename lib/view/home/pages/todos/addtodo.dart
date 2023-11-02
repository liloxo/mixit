import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/pagescontroller/todocontroller/addtodo_controller.dart';
import 'package:notes/core/components/textforms/textformfield.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/constant/sizes.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddTodoController controller = Get.put(AddTodoController());
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.fifteen, vertical: 10),
                  color: AppColors.white,
                  height: double.infinity,
                  child: Form(
                      key: controller.forkey,
                      child: Column(children: [
                        CustomTextFormField(
                          mycontroller: controller.todotask,
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return "Task Can't Be Empty";
                            }
                            return null;
                          },
                          labeltext: '',
                          hintText: 'Task',
                          isobscureText: false,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.picktime();
                                      },
                                      icon: const Icon(Icons.alarm_on_outlined,
                                          size: 35)),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: MaterialButton(
                                          onPressed: () {
                                            controller.savetask();
                                          },
                                          child: const Text('Save',
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 16))))
                                ]))
                      ])));
            });
      },
      child: const Icon(Icons.assignment_turned_in, color: AppColors.white),
    );
  }
}
