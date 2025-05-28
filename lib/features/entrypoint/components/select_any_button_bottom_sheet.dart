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
              child: Container(
                height: 56.h,
                width: double.infinity,

                decoration: BoxDecoration(

                  color:  AppColors.primary ,
                  border: Border.all(width: 1,color: AppColors.primary),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add,color: Colors.white,size: 30,)??Container(),
                    SizedBox(width: 5.w,),
                    Text(textAlign: TextAlign.center,
                      "اضافة موظف",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700
                          ,color: AppColors.textWhite ),
                    ),
                  ],
                ),

              ),

            ),
            SizedBox(
              height: 20.w,
            ),

              InkWell(
                onTap: (){navigateTo(context, AppRoutes.addTask);},
                child: Container(
                  height: 56.h,
                  width: double.infinity,

                  decoration: BoxDecoration(

                    color:  AppColors.primary ,
                    border: Border.all(width: 1,color: AppColors.primary),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,color: Colors.white,size: 30,)??Container(),
                      SizedBox(width: 5.w,),
                      Text(textAlign: TextAlign.center,
                        "اضافة مهمة",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700
                            ,color: AppColors.textWhite ),
                      ),
                    ],
                  ),

                ),
              )          ],
        ),
      ),
    );
  }
}
