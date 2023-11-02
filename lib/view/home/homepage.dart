import 'package:flutter/material.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:get/get.dart';
import 'package:notes/controller/home/homepage_controller.dart';
import 'package:notes/view/widget/custombottomappbarhome.dart';
import 'package:notes/view/widget/customtopcolumn.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(),
      builder: (controller)
    => Scaffold(
      bottomNavigationBar: const CustomBottomAppBarHome(),
      body: StreamBuilder(
        stream: controller.streamquerysnapshot(controller.lowercasetitle.elementAt(controller.currentpage)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
           return Column(
             children: [
              const SizedBox(height: 10),CustomTopColumn(
                onPressed: () async {
                  controller.signoutmeth();
                },
                onChanged: (val) {
                  if(snapshot.data.docs.length > 0){
                    controller.onSearchChanged(val);
                  }
                },
                 data: 'All ${controller.title.elementAt(controller.currentpage)}',
                 datalength: "${snapshot.data.docs.length} ${controller.lowercasetitle.elementAt(controller.currentpage)}"
               ), 
               Expanded(
                 child: controller.pages.elementAt(controller.currentpage)
               )
             ]
           );
          } else {
           return const Center(child: CircularProgressIndicator(backgroundColor: AppColors.primaryColor,color: AppColors.primaryColor,));
          }
        }
      )
    ));
  }
}