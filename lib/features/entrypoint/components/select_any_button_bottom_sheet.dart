import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_buttons.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/constants/navigation.dart';
import '../../../core/routes/app_routes.dart';
import '../../home/components/widgets_for_tasks_screen.dart';

class SelectAnyButtonBottomSheet extends StatelessWidget {
  const SelectAnyButtonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
        mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                navigateTo(context, AppRoutes.addEmployee);
              },
              child: defaultButton(
                context: context,
                isColor: true,
                width: double.infinity,
                text: 'اضافة موظف',
                icon: Icons.add,
                height: 56.h,
                textSize: 15.sp,
                toPage: (){navigateTo(context, AppRoutes.addEmployee);}

              ),

            ),
            SizedBox(
              height: 20.w,
            ),
            InkWell(
                onTap: () {
                  navigateTo(context, AppRoutes.addTask);
                },
                child: defaultButton(
                    context: context,
                    isColor: true,
                    width: double.infinity,
                    text: 'اضافة مهمة',
                    icon: Icons.add,
                    height: 56.h,
                    textSize: 15.sp,
                    toPage: (){navigateTo(context, AppRoutes.addTask);}

                ),),
          ],
        ),
      ),
    );
  }
}
