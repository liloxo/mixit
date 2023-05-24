import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes/core/constant/colors.dart';

class MySlidable extends StatelessWidget {
  final void Function(BuildContext)? onPressedDelete;
  final void Function(BuildContext)? onPressedEdit;
  final Widget child;
  const MySlidable({Key? key, this.onPressedDelete, this.onPressedEdit, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(), 
              children: [
               SlidableAction(
                borderRadius: BorderRadius.circular(5),
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.white,
                onPressed: onPressedDelete,
                icon: Icons.delete),
               SlidableAction(
                borderRadius: BorderRadius.circular(5),
                backgroundColor: AppColors.secondaryColor,
                foregroundColor: AppColors.white,
                onPressed: onPressedEdit,
                icon: Icons.edit)
              ]
            ),
            child: child
            );
  }
}