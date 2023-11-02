import 'package:flutter/material.dart';
import 'package:notes/core/components/textforms/textformfield.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/constant/sizes.dart';

class CustomTopColumn extends StatelessWidget {
  final String data;
  final String datalength;
  final void Function(String)? onChanged;
  final TextEditingController? mycontroller;
  final void Function()? onPressed;
  const CustomTopColumn({Key? key, required this.data, required this.datalength, this.onChanged, this.mycontroller, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: AppSize.fifty),
                padding: EdgeInsets.only(left: AppSize.twenty),
                child: Text(data,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: AppColors.black))
              ),
              Padding(
                padding: EdgeInsets.only(right: AppSize.fifteen,top: AppSize.seventy),
                child: IconButton(onPressed: onPressed, icon: const Icon(Icons.logout_outlined,color: AppColors.primaryColor,size: 30)),
              )  
            ]
          ),
           Padding(
            padding: EdgeInsets.only(left: AppSize.twenty,bottom: AppSize.twenty),
            child: Text(datalength,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: AppColors.grey))
          ),
          Row(
            children:  [
             Expanded(
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.fifteen),
              child: CustomTextFormField(
                onChanged: onChanged,
                labeltext: 'Search',isobscureText: false,prefixIcon: const Icon(Icons.search))
            ))
          ])
        ]
      );
  }
}