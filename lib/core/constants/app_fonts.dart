import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itsale/core/app/app.dart';

import 'package:itsale/core/constants/app_colors.dart';

class AppFonts {
  static TextStyle style20medium = GoogleFonts.tajawal(


      fontSize: 20.sp,
      fontWeight: FontWeight.w700
  );

  static TextStyle style18medium = GoogleFonts.tajawal(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700
  );

  static TextStyle style36medium = GoogleFonts.tajawal(


      fontSize: 36.sp,
      fontWeight: FontWeight.w700);

  static TextStyle style20Light = TextStyle(


      fontSize: 20.sp,
      fontWeight: FontWeight.w400);

  static TextStyle style16LightPrimary = GoogleFonts.tajawal(

      color: AppColors.primary,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400);

  static TextStyle style16Light = GoogleFonts.tajawal(

      color:globalDark ? Color(0xFFE6F4ED) : Color(0xFF575B61),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400);

  static TextStyle style20whiteMedium = GoogleFonts.tajawal(


      fontSize: 20.sp,
      fontWeight: FontWeight.w700);

  static TextStyle style20Normal = GoogleFonts.tajawal(


      fontSize: 20.sp,
      fontWeight: FontWeight.w500);

  static TextStyle style16Normal = GoogleFonts.tajawal(


      fontSize: 16.sp,
      fontWeight: FontWeight.w500);
  static TextStyle style16NormalColored = GoogleFonts.tajawal(

      color: AppColors.primary,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500);

  static TextStyle style20Bold = GoogleFonts.tajawal(


      fontSize: 20.sp,
      fontWeight: FontWeight.bold);

  static TextStyle style20BoldColored = GoogleFonts.tajawal(

      color: AppColors.primary,
      fontSize: 20.sp,

      fontWeight: FontWeight.bold);

  static TextStyle style48White = GoogleFonts.tajawal(

    fontWeight: FontWeight.w500,
    fontSize: 48.sp,

  );

  static TextStyle style12light = GoogleFonts.tajawal(

    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
// color:  AppColors.textBlack,
  );

  static TextStyle style12bold = GoogleFonts.tajawal(

    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
  );
  static TextStyle style10light = GoogleFonts.tajawal(

    fontWeight: FontWeight.w400,
    fontSize: 10.sp,

  );
  static TextStyle style12lightGrey = GoogleFonts.tajawal(

    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: AppColors.placeholder,
  );
  static TextStyle style10lightGrey = GoogleFonts.tajawal(

    fontWeight: FontWeight.w500,
    fontSize: 10.sp,
    color: AppColors.placeholder,
  );
  static TextStyle style12lightWhite = GoogleFonts.tajawal(

    fontWeight: FontWeight.w500,
    fontSize: 12.sp,

  );

  static TextStyle style12medium = GoogleFonts.tajawal(

    fontWeight: FontWeight.w700,
    fontSize: 12.sp,

  );
  static TextStyle style16semiBold = GoogleFonts.tajawal(

    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    // color: AppColors.textBlack
  );
  static TextStyle style16semiBoldError = GoogleFonts.tajawal(

      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.errorColor
  );

  static TextStyle style16MediumColor = GoogleFonts.tajawal(

    fontSize: 16.sp,
    color: Colors.blue,
    fontWeight: FontWeight.w700,
  );

  static TextStyle style12colored = GoogleFonts.tajawal(

    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: AppColors.primary,
  );
  static TextStyle style14normal = GoogleFonts.tajawal(

    fontSize: 14.sp,
    fontWeight: FontWeight.w500,


  );
  static TextStyle style14normalBlack = GoogleFonts.tajawal(

    fontSize: 14.sp,
    fontWeight: FontWeight.w500,

  );
  static TextStyle style14normalWhite = GoogleFonts.tajawal(

    fontSize: 14.sp,

    fontWeight: FontWeight.w500,
  );
}
