import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/controller/home/homepage_controller.dart';
import 'package:notes/controller/pagescontroller/todocontroller/todo_controller.dart';
import 'package:notes/core/components/slidable/slidable.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/view/home/pages/todos/addtodo.dart';
import 'package:notes/view/widget/emptycolumn/customemptycolumn.dart';

class ToDo extends StatelessWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoController controller = Get.put(TodoController()); 
    return Scaffold(
        floatingActionButton: const AddTodo(),
        body: GetBuilder<HomePageController>(builder: (obxcontroller){
          return StreamBuilder(
        stream: obxcontroller.streamquerysnapshot('todos'),
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
              data: 'No Todos',
              icon: Icons.check_box_outlined));
          }
          return Column(children: [
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data.docs.length,
                    separatorBuilder: (BuildContext context, int i) {
                      return const SizedBox(height: 7);
                    },
                    itemBuilder: (BuildContext context, int i) {
                      Map data = {'title': snapshot.data.docs[i]['title'],'timestamp': snapshot.data.docs[i]['timestamp'],'todotime': snapshot.data.docs[i]['todotime'],'todoId': snapshot.data.docs[i].id,};
                      return InkWell(
                              onTap: () {
                                controller.edittodo(data);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                    child: MySlidable(
                                      onPressedDelete: (p0) {
                                        controller.deletetask(snapshot.data.docs[i].id);
                                      },
                                      onPressedEdit: (p0) {
                                        controller.edittodo(data);
                                      },
                                      child: Container(
                                        height: 70,
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Row(children: [
                                          Checkbox(
                                              checkColor: AppColors.white,
                                              activeColor: AppColors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)),
                                              value: snapshot.data.docs[i]['isdone'],
                                              onChanged: (val) {
                                                controller.chengechecked(i, snapshot.data.docs[i].id);
                                              }),
                                          Expanded(
                                            child: Text(snapshot.data.docs[i]['title'],style: TextStyle(fontSize: 17.5,overflow: TextOverflow.ellipsis,color: snapshot.data.docs[i]['isdone']
                                                ? AppColors.grey
                                                : AppColors.black,
                                                decoration: snapshot.data.docs[i]['isdone']
                                                ? TextDecoration.lineThrough
                                                : null),
                                                maxLines: 1)),
                                           if (snapshot.data.docs[i]['todotime'] != null) 
                                             Text(DateFormat('HH:mm').format(snapshot.data.docs[i]['todotime'].toDate()), style: const TextStyle(fontSize: 17.5,color: AppColors.grey)) 
                                             
                                        ]))
                                      )
                                    ),
                              )
                            );
                    })
              )
            ]);
        }
          );
        })
      );
  }
}
