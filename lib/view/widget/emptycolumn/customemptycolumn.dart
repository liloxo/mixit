import 'package:flutter/material.dart';
import 'package:notes/core/constant/colors.dart';

class CustomEmptyColumn extends StatelessWidget {
  final IconData? icon;
  final String? data;
  const CustomEmptyColumn({Key? key, this.icon, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
         Icon(icon, size: 50, color: AppColors.grey),
         Text(data!, style: const TextStyle(color: AppColors.grey, fontSize: 17))
        ]
      )
    );
  }
}
