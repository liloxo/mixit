import 'package:flutter/material.dart';
import 'package:notes/core/constant/colors.dart';

import '../../constant/sizes.dart';

class CustomAddNoteFormField extends StatelessWidget {
  final TextEditingController? mycontroller;
  final String? Function(String?)? valid;
  final InputDecoration? decoration;
  final bool? autofocus;
  final bool titleornote;
  final int? maxLines;
  const CustomAddNoteFormField({super.key, 
         this.mycontroller, 
         this.valid, this.decoration, this.autofocus, required this.titleornote, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.twenty),
      child: TextFormField(
        maxLines: maxLines,
        style:  TextStyle(fontSize: titleornote ? 27 : 20,fontWeight: titleornote ? FontWeight.bold : FontWeight.w300),
        validator: valid,
        controller: mycontroller,
        cursorColor: AppColors.primaryColor,
        decoration: decoration,
        autofocus: autofocus!,
      ),
    );
  }
}