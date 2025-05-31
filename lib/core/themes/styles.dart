import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/themes/colors.dart';

class TextStyles {
  static TextStyle font20Weight500Primary = TextStyle(
      fontSize: 20.sp, fontWeight: FontWeight.w500, color: AppColors.primary);

  static TextStyle font20Weight500White = TextStyle(
      fontSize: 20.sp, fontWeight: FontWeight.w500, color: Colors.white);
  static TextStyle font16Weight300Black = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w300, color: ColorsManager.black);
  static TextStyle font25WeightBoldBlack = TextStyle(
      fontSize: 25.sp, fontWeight: FontWeight.bold,color: ColorsManager.black);
  static TextStyle font20Weight400BaseBlack = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.baseBlack);
  static TextStyle font20Weight400Black = TextStyle(
      fontSize: 20.sp, fontWeight: FontWeight.w400, color: ColorsManager.black);
  static TextStyle font16Weight300Emerald = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
    color: ColorsManager.emerald,
    decoration: TextDecoration.underline,
    decorationColor: ColorsManager.emerald,
    decorationStyle: TextDecorationStyle.solid,
  );
  static TextStyle font16Weight300EmeraldWithoutLine = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
    color: ColorsManager.emerald,

  );
  static TextStyle font20Weight300Emerald = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w300,
    color: ColorsManager.emerald,
  );
  static TextStyle font14Weight500FifthGrey = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.fifthGrey,
  );
  static TextStyle font12Weight500BaseBlack = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.baseBlack,
  );
  static TextStyle font16Weight400Black = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.black,
  );
  static TextStyle font16Weight300Grey = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
    color: ColorsManager.grey,
  );
  static TextStyle font20Weight500BaseBlack = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.baseBlack,
  );
  static TextStyle font18Weight500Black = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.black,
  );
}
