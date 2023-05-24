import 'package:flutter/material.dart';
import 'package:notes/core/constant/colors.dart';

class CustomButtonAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final String textbutton;
  final IconData icondata;
  final bool? active   ;
  const CustomButtonAppBar(
      {Key? key,
      required this.textbutton,
      required this.icondata,
      required this.onPressed,
      this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
        onPressed: onPressed,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icondata,
              color: active == true ? AppColors.primaryColor : AppColors.grey),
          Text(textbutton,
              style: TextStyle(
                  color: active == true ? AppColors.primaryColor : AppColors.grey))
        ]),
      ),
    );
  }
}