import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/network_image.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/features/addEmployee/data/models/add_employee_model.dart';
import 'package:itsale/features/home/data/models/all_employees_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/app/app.dart';
import '../../../core/components/back_and_forward_arrows.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';
import '../data/cubit.dart';



Widget buildEmployeeListItem(DataUser user) {
  return Container(
    width: 344.w,
    padding: const EdgeInsets.all(AppDefaults.padding / 5),
    decoration: BoxDecoration(
      color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
      border: Border.all(color: globalDark ? AppColors.borderColorDark : AppColors.borderColor, width: 0.5),
      borderRadius: BorderRadius.circular(8.0.r),
    ),
    child: Row(
      children: [
        Padding(
          padding:  EdgeInsets.only(right: 8.0.h),
          child: user.avatar != null ?  Container(
            height: 42.h,
            width: 42.w,
            decoration: BoxDecoration(
            //  color: AppColors.lightGreenColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: NetworkImageWithLoader(user.avatar!.data!.full_url.toString()),
          ) :  Container(
            height: 42.h,
            width: 42.w,
            decoration: BoxDecoration(
              color: AppColors.lightGreenColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        ),
        SizedBox(width: 10.w,),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  ' ${user.first_name.toString()} ${user.last_name.toString()}',
                //  'هنا اسم الموظف',
                  style: AppFonts.style16semiBold,
                ),
                Text(
                  user.email.toString(),
                  style: AppFonts.style12light,
                  textAlign: TextAlign.right,
                ),
                Text(
                  user.role?.id == 3 ? 'موظف' : 'مدير',
                  style: AppFonts.style12light,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async
          {
          await launchUrl(Uri(
            scheme: 'tel',
            path: user.employee_info![0].phone_1.toString(),
          ));
          },
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                // color: AppColors.lightGreenColor,
                color: AppColors.success.withOpacity(0.1),
                // border: Border.all(color: globalDark ? AppColors.borderColorDark : AppColors.borderColor, width: 0.5),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Icon(

                Icons.local_phone_outlined,
                color: AppColors.greenColor,
                size: 25.w,

              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: const ForwardArrow(),
        ),

      ],
    ),
  );
}

Widget buildAdminsListItem( DataUser user) {
  return Container(
    width: 344.w,
   // height: 65.h,
    decoration: BoxDecoration(
      color: AppColors.textWhite,
      borderRadius: BorderRadius.circular(5.r),
      border: Border.all(color: AppColors.textGreySubTitle),
    ),
    child: Row(
      children: [
        Padding(
          padding:  EdgeInsets.only(right: 8.0.h),
          child: user.avatar != null ?  Container(
            height: 42.h,
            width: 42.w,
            decoration: BoxDecoration(
            //  color: AppColors.lightGreenColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: NetworkImageWithLoader(user.avatar!.data!.full_url.toString()),
          ) :  Container(
            height: 42.h,
            width: 42.w,
            decoration: BoxDecoration(
              color: AppColors.lightGreenColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        ),
        SizedBox(width: 10.w,),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
            child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  ' ${user.first_name.toString()} ${user.last_name.toString()} ${user.id.toString()}',
                //  'هنا اسم الموظف',
                  style: AppFonts.style16semiBold,
                ),
                Text(
                  user.email.toString(),
                  style: AppFonts.style12light,
                  textAlign: TextAlign.right,
                ),

                Text(
                  user.role!.id == 3 ? 'موظف' : 'مدير',
                  style: AppFonts.style12light,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.lightGreenColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Icon(

              Icons.local_phone_outlined,
              color: AppColors.greenColor,
              size: 25.w,

            ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(left: 8.w),
          child: const ForwardArrow(),
        ),

      ],
    ),
  );
}
