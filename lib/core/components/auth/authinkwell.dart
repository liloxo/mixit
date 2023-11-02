import 'package:flutter/material.dart';
import 'package:notes/core/constant/colors.dart';
import 'package:notes/core/constant/sizes.dart';

class AuthInkWell extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const AuthInkWell({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
         width: AppSize.onethirty,
         height: AppSize.fifty,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(20),
           color: AppColors.primaryColor
         ),
         child: InkWell(
           onTap: onTap,
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Text(title,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500)),
              const Icon(Icons.arrow_right_outlined,color: Colors.white,size: 30,)
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
            height: AppSize.fifty,
            width: AppSize.onethirty,
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
            margin: EdgeInsets.symmetric(vertical: AppSize.thirtyfive),
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