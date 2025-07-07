import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_colors.dart';

Widget defaultButton(
        {required BuildContext context,
        required String text,
        required double width,
        required double height,
        required bool isColor,
        IconData? icon,
        required double textSize,
        required Function() toPage}) =>
    InkWell(
      onTap: toPage,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isColor ? AppColors.primary : AppColors.textWhite,
          border: Border.all(width: 1, color: AppColors.primary),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              text,
              style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.w700,
                  color: isColor ? AppColors.textWhite : AppColors.primary),
            ),
          ],
        ),
      ),
    );
