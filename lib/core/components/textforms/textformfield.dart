import 'package:flutter/material.dart';
import 'package:notes/core/constant/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? mycontroller;
  final bool? isobscureText;
  final TextInputType? keyboardType;
  final String? hintText;
  final String labeltext;
  final IconData? iconData;
  final Widget? prefixIcon;
  final String? Function(String?)? valid;
  final void Function()? onTapIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  const CustomTextFormField({super.key, 
         this.mycontroller, 
         this.isobscureText, 
         this.keyboardType, 
         this.hintText, 
         required this.labeltext, 
         this.onTapIcon, 
         this.iconData, 
         this.prefixIcon, 
         this.valid, this.suffixIcon, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        controller: mycontroller,
        validator: valid,
        onChanged: onChanged ,
        obscureText: isobscureText!,
        keyboardType: keyboardType,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          focusColor: AppColors.primaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 2.2,
              color: AppColors.primaryColor
            )
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          label: Text(labeltext,style: const TextStyle(color: AppColors.grey,fontSize: 20,fontWeight: FontWeight.w500)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.primaryColor,
          suffixIcon: suffixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))        
        ),
      ),
    );
  }
}