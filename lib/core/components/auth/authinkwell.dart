import 'package:flutter/material.dart';
import 'package:notes/core/constant/colors.dart';

class AuthInkWell extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final void Function()? onTapTwo;
  const AuthInkWell({super.key, required this.title, this.onTap,this.onTapTwo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
         width: 130,
         height: 50,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(20),
           color: AppColors.primaryColor
         ),
         child: InkWell(
           onTap: onTap,
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Text(title,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500)),
              const Icon(Icons.arrow_right_outlined,color: Colors.white,size: 40,)
             ]),
         )
        )
      ]
    );
  }
}

class AuthGuest extends StatelessWidget {
  final void Function()? onTap;
  const AuthGuest({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.only(left: 10) ,
            height: 50,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.grey,
            ),
            child: InkWell(
              onTap: onTap,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: const[
              Text('Guest  ',style: TextStyle(color: AppColors.white,fontSize: 20,fontWeight: FontWeight.w500)),
              Icon(Icons.person,color: Colors.white)
             ])
            )
          );
  }
}

class AuthChangePage extends StatelessWidget {
  final String title;
  final String titletwo;
  final void Function()? onTap;
  const AuthChangePage({super.key, required this.title, required this.titletwo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.symmetric(vertical: 35),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title ,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: AppColors.grey)),
             InkWell(
              onTap: onTap,
              child: Text(titletwo,style: const TextStyle(color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.bold))
             )
              ]
             )
           );
  }
}