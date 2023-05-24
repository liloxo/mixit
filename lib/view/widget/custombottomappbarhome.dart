import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/home/homepage_controller.dart';
import 'package:notes/view/widget/custombottomappbar.dart';

class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        builder: (controller) => BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              ...List.generate(controller.pages.length, (index) {
                return CustomButtonAppBar(
                    textbutton: controller.title[index],
                    icondata: controller.icons[index],
                    onPressed: () {
                      controller.changepage(index);
                    },
                    active: controller.currentpage == index ? true : false);
              })
            ])));
  }
}
