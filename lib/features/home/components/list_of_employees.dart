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
import '../../../core/localization/app_localizations.dart';
import '../data/cubit.dart';

bool hasValidAvatar(DataUser user) {
  print('Avatar URL: ${user.avatar?.data?.full_url}');

  return user.avatar != null &&
      user.avatar!.data?.full_url != null &&
      user.avatar!.data!.full_url!.isNotEmpty;
}

Widget buildEmployeeListItem(DataUser user, VoidCallback onTapTele,BuildContext context) {
  return Container(
    width: 344.w,
    padding: const EdgeInsets.all(AppDefaults.padding / 5),
    decoration: BoxDecoration(
      color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
      border: Border.all(
          color: globalDark ? AppColors.borderColorDark : AppColors.borderColor,
          width: 0.5),
      borderRadius: BorderRadius.circular(8.0.r),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.0.h),
          child: Container(
            height: 42.h,
            width: 42.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: hasValidAvatar(user)
                ? NetworkImageWithLoader(user.avatar!.data!.full_url!)
                : Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGreenColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.first_name} ${user.last_name}',
                  style: AppFonts.style16semiBold,
                ),
                Text(
                  user.email.toString(),
                  style: AppFonts.style12light,
                  textAlign: TextAlign.right,
                ),
                Text(
                  (user.role is int ? user.role == 3 : user.role?['id'] == 3) ?  AppLocalizations.of(context)!.translate('employee') : AppLocalizations.of(context)!.translate('manager'),
                  style: AppFonts.style12light,
                  textAlign: TextAlign.right,
                ),

              ],
            ),
          ),
        ),
        InkWell(
          onTap: onTapTele,
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
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

Widget buildAdminsListItem(DataUser user,BuildContext context) {
  return Container(
    width: 344.w,
    decoration: BoxDecoration(
      color: AppColors.textWhite,
      borderRadius: BorderRadius.circular(5.r),
      border: Border.all(color: AppColors.textGreySubTitle),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.0.h),
          child: Container(
            height: 42.h,
            width: 42.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: hasValidAvatar(user)
                ? NetworkImageWithLoader(user.avatar!.data!.full_url!)
                : Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGreenColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.first_name} ${user.last_name} ${user.id}',
                  style: AppFonts.style16semiBold,
                ),
                Text(
                  user.email.toString(),
                  style: AppFonts.style12light,
                  textAlign: TextAlign.right,
                ),
                Text(
                  user.role?.id == 3 ?  AppLocalizations.of(context)!.translate('employee'): AppLocalizations.of(context)!.translate('manager'),
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
          padding: EdgeInsets.only(left: 8.w),
          child: const ForwardArrow(),
        ),
      ],
    ),
  );
}
