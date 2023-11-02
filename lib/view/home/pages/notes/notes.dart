import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/controller/home/homepage_controller.dart';
import 'package:notes/controller/pagescontroller/notescontroller/notes_controller.dart';
import 'package:notes/core/components/slidable/slidable.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/constant/sizes.dart';
import 'package:notes/view/widget/emptycolumn/customemptycolumn.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotesController controller = Get.put(NotesController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Get.toNamed('/addnote');
          },
          child: const Icon(Icons.add, color: AppColors.white),
        ),
        body: GetBuilder<HomePageController>(
          builder: (obxcontroller){
            return StreamBuilder(
        stream: obxcontroller.streamquerysnapshot('notes'),        
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
                data: 'No Notes',
                icon: Icons.note_outlined));
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
                    Map data = {'title': snapshot.data.docs[i].data()['title'], 'content': snapshot.data.docs[i].data()['content'],'timestamp': snapshot.data.docs[i].data()['timestamp'],'noteId': snapshot.data.docs[i].id};
                    return InkWell(
                        onTap: () {
                          controller.editNote(data);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                              child: MySlidable(
                                onPressedDelete: (p0) {
                                  controller.deleteNote(snapshot.data.docs[i].id);
                                },
                                onPressedEdit: (p0) {
                                  controller.editNote(data);
                                },
                                child: Container(
                                padding: const EdgeInsets.only(right: 10),
                                height: AppSize.eighty,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10,left: AppSize.fifteen),
                                  child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                             Expanded(
                                              child: Text(snapshot.data.docs[i].data()['title'],style: const TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17.5,
                                                  overflow: TextOverflow.ellipsis),maxLines: 1))
                                          ]),
                                          Row(
                                           children: [
                                           Text(DateFormat('MMMd').format(snapshot.data.docs[i]['timestamp'].toDate()),style: const TextStyle(fontSize: 15,color:AppColors.grey,fontWeight: FontWeight.w500))
                                           ]
                                          )
                                        ]
                                      )
                                )
                              )
                                )
                          )
                        ));
                  })
            )
          ]);
        }
          );
          }
          )
      );
    
  }
}
